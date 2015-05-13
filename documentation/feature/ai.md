---
layout: wiki
title: AI (Artifical Intelligence)
group: feature
order: 5
parent: wiki
---

# Overview
## Adjusted AI skill values
The idea here is to reduce the AI's godlike aiming capabilties while retaining it's high intelligence. The AI should be smart enough to move through a town, but also be 'human' in their reaction time and aim.
Note: All these values can still be adjusted via scripts, these arrays just change what 0 & 1 are for setSkill.
## Firing in burst mode
AIs will now use the automatic mode of their weapons on short distances, instead of always relying on firing single shots in quick succession.
## Longer engagement ranges
The maximum engagement ranges are increased: AI will fire in bursts with variable length on high ranges of 500 - 700 meters, depending on their weapon and optic.
## No deadzones in CQB
Some weapons had minimum engagement ranges. If you were as close as 2 meters to an AAF soldier, he wouldn't open fire, because the AI couldn't find any valid fire mode for their weapon. AGM removes this behaviour mostly notable in CQB by adding a valid firing mode.
## No scripting
All changes of AGM AI are config based to ensure full compatibility with advanced AI modifications like ASR AI.

# Usage
Short overview of how to use the feature, e.g. menu options, key bindings, 
instructions. May not apply to all modules.

# Dependencies
List of modules that must be present for this module to work.
