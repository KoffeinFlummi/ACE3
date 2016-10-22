
PREP(actionKeysNamesConverted);
PREP(addCanInteractWithCondition);
PREP(addLineToDebugDraw);
PREP(addSetting);
PREP(addToInventory);
PREP(assignedItemFix);
PREP(assignObjectsInList);
PREP(ambientBrightness);
PREP(arithmeticGetResult);
PREP(arithmeticSetSource);
PREP(ASLToPosition);
PREP(binarizeNumber);
PREP(blurScreen);
PREP(cachedCall);
PREP(canGetInPosition);
PREP(canInteractWith);
PREP(changeProjectileDirection);
PREP(checkFiles);
PREP(checkPBOs);
PREP(claim);
PREP(codeToString);
PREP(createOrthonormalReference);
PREP(currentChannel);
PREP(debug);
PREP(debugModule);
PREP(defineVariable);
PREP(deviceKeyFindValidIndex);
PREP(deviceKeyRegisterNew);
PREP(deprecateComponent);
PREP(disableAI);
PREP(disableUserInput);
PREP(displayIcon);
PREP(displayText);
PREP(displayTextPicture);
PREP(displayTextStructured);
PREP(doAnimation);
PREP(doGesture);
PREP(dropBackpack);
PREP(endRadioTransmission);
PREP(eraseCache);
PREP(errorMessage);
PREP(findUnloadPosition);
PREP(firedEH);
PREP(fixCollision);
PREP(fixFloating);
PREP(fixLoweredRifleAnimation);
PREP(fixPosition);
PREP(getAllDefinedSetVariables);
PREP(getDeathAnim);
PREP(getDefaultAnim);
PREP(getDefinedVariable);
PREP(getDefinedVariableDefault);
PREP(getDefinedVariableInfo);
PREP(getFirstObjectIntersection);
PREP(getFirstTerrainIntersection);
PREP(getGunner);
PREP(getInPosition);
PREP(getMapData);
PREP(getMapGridData);
PREP(getMapGridFromPos);
PREP(getMapPosFromGrid);
PREP(getMarkerType);
PREP(getMGRSdata);
PREP(getName);
PREP(getNumberMagazinesIn);
PREP(getPitchBankYaw);
PREP(getSettingData);
PREP(getStaminaBarControl);
PREP(getTargetAzimuthAndInclination);
PREP(getTargetDistance);
PREP(getTargetObject);
PREP(getTurnedOnLights);
PREP(getTurretDirection);
PREP(getUavControlPosition);
PREP(getVehicleCargo);
PREP(getVehicleCodriver);
PREP(getVersion);
PREP(getWeaponAzimuthAndInclination);
PREP(getWeaponIndex);
PREP(getWeaponState);
PREP(getWindDirection);
PREP(getZoom);
PREP(goKneeling);
PREP(hadamardProduct);
PREP(handleEngine);
PREP(handleModifierKey);
PREP(handleModifierKeyUp);
PREP(hasItem);
PREP(hasMagazine);
PREP(headBugFix);
PREP(hideUnit);
PREP(interpolateFromArray);
PREP(inTransitionAnim);
PREP(isAwake);
PREP(isEngineer);
PREP(isEOD);
PREP(isFeatureCameraActive);
PREP(isInBuilding);
PREP(isModLoaded);
PREP(isPlayer);
PREP(isUnderwater);
PREP(lightIntensityFromObject);
PREP(loadPerson);
PREP(loadPersonLocal);
PREP(loadSettingsFromProfile);
PREP(loadSettingsOnServer);
PREP(loadSettingsLocalizedText);
PREP(moduleCheckPBOs);
PREP(moduleLSDVehicles);
PREP(muteUnit);
PREP(muteUnitHandleInitPost);
PREP(muteUnitHandleRespawn);
PREP(numberToDigits);
PREP(numberToDigitsString);
PREP(numberToString);
PREP(onAnswerRequest);
PREP(owned);
PREP(parseList);
PREP(playConfigSound3D);
PREP(player);
PREP(playerSide);
PREP(positionToASL);
PREP(progressBar);
PREP(readSettingFromModule);
PREP(readSettingsFromParamsArray);
PREP(receiveRequest);
PREP(removeCanInteractWithCondition);
PREP(removeSpecificMagazine);
PREP(requestCallback);
PREP(resetAllDefaults);
PREP(restoreVariablesJIP);
PREP(runAfterSettingsInit);
PREP(sanitizeString);
PREP(sendRequest);
PREP(serverLog);
PREP(setApproximateVariablePublic);
PREP(setDefinedVariable);
PREP(setDisableUserInputStatus);
PREP(setHearingCapability);
PREP(setName);
PREP(setParameter);
PREP(setPitchBankYaw);
PREP(setProne);
PREP(setSetting);
PREP(setSettingFromConfig);
PREP(setVariableJIP);
PREP(setVariablePublic);
PREP(setVolume);
PREP(showHud);
PREP(statusEffect_addType);
PREP(statusEffect_get);
PREP(statusEffect_localEH);
PREP(statusEffect_resetVariables);
PREP(statusEffect_respawnEH);
PREP(statusEffect_sendEffects);
PREP(statusEffect_set);
PREP(stringCompare);
PREP(stringToColoredText);
PREP(stringRemoveWhiteSpace);
PREP(switchToGroupSide);
PREP(throttledPublicVariable);
PREP(toBin);
PREP(toBitmask);
PREP(toHex);
PREP(toNumber);
PREP(unhideUnit);
PREP(uniqueElements);
PREP(unloadPerson);
PREP(unloadPersonLocal);
PREP(unmuteUnit);
PREP(useItem);
PREP(useMagazine);
PREP(watchVariable);
PREP(waveHeightAt);

PREP(translateToWeaponSpace);
PREP(translateToModelSpace);

// Model and drawing helpers
PREP(worldToScreenBounds);

// config items
PREP(getItemType);
PREP(getWeaponType);
PREP(getWeaponModes);
PREP(getWeaponMuzzles);

// config objects
PREP(getConfigGunner);
PREP(getConfigCommander);
PREP(getSelectionsWithoutHitPoints);
PREP(getReflectorsWithSelections);
PREP(getLightProperties);
PREP(getLightPropertiesWeapon);
PREP(getVehicleCrew);
PREP(getVehicleUAVCrew);

// turrets
PREP(getTurretIndex);
PREP(getTurretConfigPath);
PREP(getTurretGunner);
PREP(getTurretCommander);
PREP(getTurretCopilot);
PREP(getDoorTurrets);
PREP(getTurretsFFV);
PREP(getTurretsOther);
PREP(hasHatch);

// ACE_Debug
PREP(getChildren);
PREP(getDisplayConfigName);
PREP(monitor);
PREP(showUser);

PREP(dumpPerformanceCounters);
PREP(dumpArray);

// Synchronized Events
PREP(syncedEventPFH);
PREP(addSyncedEventHandler);
PREP(removeSyncedEventHandler);
PREP(requestSyncedEvent);
PREP(syncedEvent);

PREP(_handleSyncedEvent);
PREP(_handleRequestSyncedEvent);
PREP(_handleRequestAllSyncedEvents);

// other eventhandlers
PREP(addActionEventHandler);
PREP(addActionMenuEventHandler);
PREP(addMapMarkerCreatedEventHandler);

PREP(removeActionEventHandler);
PREP(removeActionMenuEventHandler);
PREP(removeMapMarkerCreatedEventHandler);
