local L = AceLibrary("AceLocale-2.2"):new("MoneyFu")

L:RegisterTranslations("frFR", function()
	return {
		["NAME"] = "FuBar - MoneyFu",
		["DESCRIPTION"] = "Garde le compte de votre argent et de l'argent vos autres personnages du royaume.",
		["COMMANDS"] = {"/monfu", "/moneyfu"},
		["TEXT_TOTAL"] = "Total",
		["TEXT_SESSION_RESET"] = "Réinitialiser la session",
		["TEXT_THIS_SESSION"] = "Cette session",
		["TEXT_GAINED"] = "Gagné",
		["TEXT_SPENT"] = "Dépensé",
		["TEXT_AMOUNT"] = "Total",
		["TEXT_PER_HOUR"] = "Par heure",

		["ARGUMENT_RESETSESSION"] = "resetSession",

		["MENU_RESET_SESSION"] = "Réinitialiser la session",
		["MENU_CHARACTER_SPECIFIC_CASHFLOW"] = "Afficher les fluctuations d'argent spécifiques de ce personnages",
		["MENU_PURGE"] = "Purger",
		["MENU_SHOW_GRAPHICAL"] = "Afficher avec des pièces",
		["MENU_SHOW_FULL"] = "Afficher en style complet",
		["MENU_SHOW_SHORT"] = "Afficher en style court",
		["MENU_SHOW_CONDENSED"] = "Afficher en style condensé",
		["SIMPLIFIED_TOOLTIP"] = "Tooltip simplifié",

		["TEXT_CHARACTERS"] = "Personnages",
		["TEXT_PROFIT"] = "Profit",
		["TEXT_LOSS"] = "Perte",
	
		["HINT"] = "Clic pour prendre de l'argent"
	}
end)
