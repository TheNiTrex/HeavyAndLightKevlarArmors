//---------------------------------------------------------------------------------------
//  FILE:   XComDownloadableContentInfo_HeavyAndLightKevlarArmors.uc                                    
//           
//	Use the X2DownloadableContentInfo class to specify unique mod behavior when the 
//  player creates a new campaign or loads a saved game.
//  
//---------------------------------------------------------------------------------------
//  Copyright (c) 2016 Firaxis Games, Inc. All rights reserved.
//---------------------------------------------------------------------------------------

class X2DownloadableContentInfo_HeavyAndLightKevlarArmors extends X2DownloadableContentInfo;

	var config(HeavyAndLightKevlarArmors) int MEDIUM_KEVLAR_HEALTH_BONUS;
	var config(HeavyAndLightKevlarArmors) int LIGHT_KEVLAR_MOBILITY_BONUS;

/// <summary>
/// This method is run if the player loads a saved game that was created prior to this DLC / Mod being installed, and allows the 
/// DLC / Mod to perform custom processing in response. This will only be called once the first time a player loads a save that was
/// create without the content installed. Subsequent saves will record that the content was installed.
/// </summary>
static event OnLoadedSavedGame() {

	//`log("TEST - OLSG");

	AddHeavyKevlarArmor();

}

/// <summary>
/// Called when the player starts a new campaign while this DLC / Mod is installed
/// </summary>
static event InstallNewCampaign(XComGameState StartState) {

	//Not needed, Item Templates are added at campaign start if Template.StartingItem is set to True

}

static function AddHeavyKevlarArmor() {

	local XComGameState NewGameState;
	local XComGameState_Item NewItemState;
	local XComGameStateHistory History;
	local XComGameState_HeadquartersXCom XComHQ;
	local X2ItemTemplateManager TemplateManager;
	local X2ItemTemplate HeavyKevlarArmor;

	History = `XCOMHISTORY;
	XComHQ = `XCOMHQ;

	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Adding Heavy Kevlar Armor");

	XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
	XComHQ = XComGameState_HeadquartersXCom(NewGameState.ModifyStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));

	NewGameState.AddStateObject(XComHQ);

	TemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();

	HeavyKevlarArmor = TemplateManager.FindItemTemplate('HeavyKevlarArmor');

	if (HeavyKevlarArmor != none) { //Failsafe

		NewItemState = HeavyKevlarArmor.CreateInstanceFromTemplate(NewGameState);
		XComHQ.AddItemToHQInventory(NewItemState);
		History.AddGameStateToHistory(NewGameState);

	} else { //Should never trigger, but just good practice
	
		History.CleanupPendingGameState(NewGameState);

	} 
}

static function OnPostTemplatesCreated() { //Use OPTC to modify base-game Kevlar Armors

	local X2ItemTemplateManager TemplateManager;
	local X2ArmorTemplate Template;

	TemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();

	Template = X2ArmorTemplate(TemplateManager.FindItemTemplate('KevlarArmor'));
	Template.ArmorClass = 'medium'; //Reclassify Kevlar Armor as Medium Armor so it benefits from Breakthrough bonuses 
	Template.Abilities.AddItem('MediumKevlarArmorStats');
	Template.SetUIStatMarkup(class'XLocalizedData'.default.HealthLabel, eStat_HP, class'X2Ability_HeavyAndLightKevlarArmors'.default.MEDIUM_KEVLAR_HEALTH_BONUS, true);

	Template = X2ArmorTemplate(TemplateManager.FindItemTemplate('KevlarArmor_DLC_Day0'));
	Template.ArmorClass = 'light'; //Reclassify Resistance Warrior Armor as Light Armor so it benefits from Breakthrough bonuses 
	Template.Abilities.AddItem('LightKevlarArmorStats');
	Template.SetUIStatMarkup(class'XLocalizedData'.default.MobilityLabel, eStat_Mobility, class'X2Ability_HeavyAndLightKevlarArmors'.default.LIGHT_KEVLAR_MOBILITY_BONUS, true);

}