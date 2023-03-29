// Copyright (c) 2023, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:constraint_solver/constraint_solver.dart';
import 'package:intl/intl.dart';

final dateFormat = DateFormat.yMEd().add_jms();

// A scheduling problem, where the variables are a user's tasks,
// and the domain is the times where the user is available.
void main() {
  final tasks = [
    Task('Feed the dogs', Duration(minutes: 15)),
    Task('Work on highlight', Duration(minutes: 15)),
    Task('Eat breakfast', Duration(minutes: 30)),
  ];

  final timeSlots = [
    TimeSlot(
      DateTime(2023, 2, 14, 8),
      DateTime(2023, 2, 14, 9),
    ),
    TimeSlot(
      DateTime(2023, 2, 14, 11),
      DateTime(2023, 2, 14, 12),
    ),
  ];

  final scheduledTasks = scheduleTasks(tasks, timeSlots);

  for (var task in scheduledTasks.keys) {
    final startTime = scheduledTasks[task];
    if (startTime == null) {
      throw ('Unexpected null value in map: $scheduledTasks');
    }
    print('$task: ${dateFormat.format(startTime)}');
  }
}

Map<Task, DateTime> scheduleTasks(List<Task> tasks, List<TimeSlot> timeSlots) {
  final domains = <Task, List<TimeSlot>>{};

  // Any task can be scheduled into any time slot:
  for (var task in tasks) {
    domains[task] = timeSlots;
  }

  final csp = CSP<Task, TimeSlot>(tasks, domains);

  csp.addConstraint(TaskConstraint(tasks));

  final result = csp.backtrackingSearch();

  if (result == null) {
    throw ('The tasks could not be scheduled in the provided time slots.');
  }

  // Assign an actual time to schedule each task in the time slot. For example,
  // If there are two 30 minute tasks in a 60 minute time slot, one should be
  // scheduled at the start of the hour and the other at the 30-minute mark.

  // The time each task should be scheduled at.
  Map<Task, DateTime> scheduledTasks = {};
  // The amount of time that has been scheduled in a TimeSlot, used to determine
  // the time for the next task in the time slot.
  Map<TimeSlot, Duration> scheduledTimeInTimeSlots = {};
  for (var timeSlot in timeSlots) {
    scheduledTimeInTimeSlots[timeSlot] = Duration(minutes: 0);
  }

  for (var entry in result.entries) {
    final task = entry.key;

    final timeSlot = entry.value;
    final scheduledTimeInTimeSlot = scheduledTimeInTimeSlots[timeSlot];
    if (scheduledTimeInTimeSlot == null) {
      throw ('Unexpected null value in map: $scheduledTimeInTimeSlot');
    }
    scheduledTasks[task] = timeSlot.start.add(scheduledTimeInTimeSlot);
    scheduledTimeInTimeSlots[timeSlot] =
        scheduledTimeInTimeSlot + task.duration;
  }

  return scheduledTasks;
}

class Task {
  final String name;
  final Duration duration;

  Task(this.name, this.duration);

  @override
  String toString() => '$name (${duration.inMinutes}m)';
}

class TimeSlot {
  final DateTime start;
  final DateTime end;

  TimeSlot(this.start, this.end);

  Duration get duration => end.difference(start);

  @override
  String toString() => '($start, $end)';
}

class TaskConstraint extends Constraint<Task, TimeSlot> {
  TaskConstraint(super.variables);

  @override
  bool isSatisfied(Map<Task, TimeSlot> assignment) {
    // Create a map containing the remaining time for each time slot
    Map<TimeSlot, Duration> remainingTime = {};
    for (var timeSlot in assignment.values) {
      remainingTime[timeSlot] =
          Duration(milliseconds: timeSlot.duration.inMilliseconds);
    }

    // Check that each task fits in the available time slot.
    for (var task in assignment.keys) {
      final timeSlot = assignment[task]!;
      final remainingTimeInTimeSlot = remainingTime[timeSlot];

      if (remainingTimeInTimeSlot == null) {
        return false;
      }

      // If there's not enough time remaining, this is not a valid assignment.
      if (remainingTimeInTimeSlot < task.duration) {
        return false;
      }

      // Subtract the task's time from the remaining time in the time slot.
      remainingTime[timeSlot] = remainingTimeInTimeSlot - task.duration;
    }

    return true;
  }
}
