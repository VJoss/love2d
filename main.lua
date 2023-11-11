-- ==============================================
--  CONSTANTES
-- ==============================================
require("menu")
require("jeu")

scene = "menu"

-- ==============================================
--  LOADS
-- ==============================================
function love.load()
    loadMenu()
end

-- ==============================================
--  UPDATE
-- ==============================================
function love.update(dt)
    if scene == "menu" then
        updateMenu(dt)

    elseif scene == "jeu" then
        updateJeu(dt)
    end

end

-- ==============================================
--  DRAW
-- ==============================================
function love.draw()
    if scene == "menu" then
        drawMenu(dt)

    elseif scene == "jeu" then
        drawJeu(dt)
    end

end
