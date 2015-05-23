---
layout: wiki
title: Ballistics
description: Realistic ballistic improvements
group: feature
order: 5
parent: wiki
---

## 1. Overview

### 1.1 Realistic ballistics
Changes include adjusted muzzle velocity, air friction and dispersion based on real life values.

### 1.2 Weaker body armor
Decreases protection values of vests, CSAT uniforms and various campaign only gear to better represent realism.

### 1.3 Realistic silencers and subsonic ammunition
Silencers no longer decrease the muzzle velocity and are generally less effective when used with normal ammunition. They now only remove the muzzle blast and flash. To prevent the crack caused by supersonic projectiles, ACE3 introduces subsonic ammunition for the 7.62mm caliber. This is also fully compatible with AI.

### 1.4 Flash suppressors
Flash suppressors are devices that reduce the muzzle flash while firing by cooling or dispersing the burning gases that exit the muzzle. Its intent is to reduce the chances that the shooter will be blinded in low-light shooting conditions as well as reducing the intensity of the flash visible to the enemy.

### 1.5 Armor piercing ammunition
Armor piercing rounds have higher penetration values against light armored targets and other obstacles on the battlefield. Their drawback is a slightly decreased man-stopping power. AP rounds are available in multiple calibers incudling 5.56mm and 7.62mm.

### 1.6 IR-Dim tracer ammunition
IR-Dim ammunition is similar to tracer rounds, but these tracers are only visible using night vision devices.

### 1.7 M118 long range ammunition
The M14 EBR now uses ammunition with decreased muzzle velocity and air friction to improve precision and energy retention at long ranges.

### 1.8 Fully config-based
This module applies configuration changes only and does not decrease game performance.

## 2. Dependencies

`ace_common`
