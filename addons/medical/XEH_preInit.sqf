#include "script_component.hpp"

ADDON = false;

PREP(actionCheckBloodPressure);
PREP(actionCheckBloodPressureLocal);
PREP(actionCheckPulse);
PREP(actionCheckPulseLocal);
PREP(actionCheckResponse);
PREP(actionDiagnose);
PREP(actionPlaceInBodyBag);
PREP(actionRemoveTourniquet);
PREP(actionLoadUnit);
PREP(actionUnloadUnit);
PREP(addHeartRateAdjustment);
PREP(addToInjuredCollection);
PREP(addToLog);
PREP(addToTriageCard);
PREP(addUnconsciousCondition);
PREP(addUnloadPatientActions);
PREP(adjustPainLevel);
PREP(canAccessMedicalEquipment);
PREP(canTreat);
PREP(canTreatCached);
PREP(determineIfFatal);
PREP(getBloodLoss);
PREP(getBloodPressure);
PREP(getBloodVolumeChange);
PREP(getCardiacOutput);
PREP(getTypeOfDamage);
PREP(getHeartRateChange);
PREP(getTriageStatus);
PREP(getUnconsciousCondition);
PREP(handleDamage);
PREP(handleDamage_advanced);
PREP(handleDamage_advancedSetDamage);
PREP(handleDamage_airway);
PREP(handleDamage_basic);
PREP(handleDamage_fractures);
PREP(handleDamage_internalInjuries);
PREP(handleDamage_wounds);
PREP(handleDamage_woundsOld);
PREP(handleUnitVitals);
PREP(handleKilled);
PREP(handleLocal);
PREP(handleBandageOpening);
PREP(hasItem);
PREP(hasItems);
PREP(hasMedicalEnabled);
PREP(hasTourniquetAppliedTo);
PREP(init);
PREP(isBeingCarried);
PREP(isBeingDragged);
PREP(isInMedicalFacility);
PREP(isInMedicalVehicle);
PREP(isMedic);
PREP(isMedicalVehicle);
PREP(isInStableCondition);
PREP(itemCheck);
PREP(modifyMedicalAction);
PREP(onMedicationUsage);
PREP(onWoundUpdateRequest);
PREP(onPropagateWound);
PREP(onSelectionDamage);
PREP(onFallDamage);
PREP(onCollisionDamage);
PREP(onDrowningDamage);
PREP(parseConfigForInjuries);
PREP(playInjuredSound);
PREP(selectionNameToNumber);
PREP(setCardiacArrest);
PREP(setDead);
PREP(setHitPointDamage);
PREP(setStructuralDamage);
PREP(setUnconscious);
PREP(treatment);
PREP(treatment_failure);
PREP(treatment_success);
PREP(treatmentAdvanced_bandage);
PREP(treatmentAdvanced_bandageLocal);
PREP(treatmentAdvanced_CPR);
PREP(treatmentAdvanced_CPRLocal);
PREP(treatmentAdvanced_fullHeal);
PREP(treatmentAdvanced_fullHealLocal);
PREP(treatmentAdvanced_fullHealTreatmentTime);
PREP(treatmentAdvanced_medication);
PREP(treatmentAdvanced_medicationLocal);
PREP(treatmentAdvanced_surgicalKit_onProgress);
PREP(treatmentBasic_bandage);
PREP(treatmentBasic_bandageLocal);
PREP(treatmentBasic_bloodbag);
PREP(treatmentBasic_bloodbagLocal);
PREP(treatmentBasic_epipen);
PREP(treatmentBasic_morphine);
PREP(treatmentBasic_morphineLocal);
PREP(treatmentIV);
PREP(treatmentIVLocal);
PREP(treatmentTourniquet);
PREP(treatmentTourniquetLocal);
PREP(useItem);
PREP(useItems);
PREP(displayPatientInformation);
PREP(displayTriageCard);
PREP(dropDownTriageCard);
PREP(moduleMedicalSettings);
PREP(moduleAdvancedMedicalSettings);
PREP(moduleReviveSettings);
PREP(moduleAssignMedicRoles);
PREP(moduleAssignMedicalVehicle);
PREP(moduleAssignMedicalFacility);
PREP(copyDeadBody);
PREP(requestWoundSync);
PREP(unconsciousPFH);

// Networked litter
PREP(createLitter);
PREP(handleCreateLitter);

GVAR(injuredUnitCollection) = [];
GVAR(IVBags) = [];

DFUNC(handleDamage_assignWounds) = if ("ace_medical" callExtension "version" == "") then { DFUNC(handleDamage_woundsOld) } else { DFUNC(handleDamage_wounds)};

call FUNC(parseConfigForInjuries);

GVAR(HITPOINTS) = ["HitHead", "HitBody", "HitLeftArm", "HitRightArm", "HitLeftLeg", "HitRightLeg"];
GVAR(SELECTIONS) = ["head", "body", "hand_l", "hand_r", "leg_l", "leg_r"];

ADDON = true;
