--$Id: OneCore.lua 14762 2006-10-22 04:06:29Z ckknight $-- 

local L = AceLibrary("AceLocale-2.2"):new("OneCore")

L:RegisterTranslations("enUS", function()
   return {
      ["Quiver"]	= true,
      ["Soul Bag"]	= true,
      ["Container"]	= true,
      ["Bag"]	= true,
    }
end)

L:RegisterTranslations("zhCN", function()
   return {
      ["Quiver"]	= "箭袋",
      ["Soul Bag"]	= "灵魂袋",
      ["Container"]	= "背包",
      ["Bag"]	    = "包裹",
   }
end)

L:RegisterTranslations("deDE", function()
   return {
      ["Quiver"]	= "K\195\182cher",
      ["Soul Bag"]	= "Seelentasche",
      ["Container"]	= "Beh\195\164lter",
      ["Bag"]	    = "Beh\195\164lter",
   }
end)

L:RegisterTranslations("koKR", function()
   return {
      ["Quiver"]	= "화살통",
      ["Soul Bag"]	= "영혼의 가방",
      ["Container"]	= "가방",
      ["Bag"]	    = "가방",
   }
end)

L:RegisterTranslations("frFR", function()
  return {
     ["Quiver"]        = "Carquois",
     ["Soul Bag"]      = "Sac d'\195\162me",
     ["Container"]     = "Conteneur",
     ["Bag"]   = "Conteneur",
  }
end)