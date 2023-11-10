-- ==============================================
--  INIT VARIABLES 
-- ==============================================
pad = {}
pad.x = 20
pad.y = love.graphics.getHeight() / 2 - 40
pad.largeur = 20
pad.hauteur = 79

pad2 = {}
pad2.x = love.graphics.getWidth() - 40
pad2.y = love.graphics.getHeight() / 2 - 40
pad2.largeur = 20
pad2.hauteur = 79

balle = {}
balle.x = 400
balle.y = 300
balle.largeur = 20
balle.hauteur = 20
balle.vitesse_x = 0
balle.vitesse_y = 0
scorePlayer_1 = 0
scorePlayer_2 = 0

-- ==============================================
--  RANDOM
-- ==============================================
function randomNegativeOrPositive()
    rng = love.math.newRandomGenerator()
    rng:setSeed(os.time())
    number = rng:random(-1, 1)
    if number >= 0 then
        return -1
    else
        return 1
    end

end

-- ==============================================
--  INIT JEU
-- ==============================================
function initJeu()

    function newAnimation(image, width, height, duration)
        local animation = {}
        animation.spriteSheet = image;
        animation.quads = {};

        for y = 0, image:getHeight() - height, height do
            for x = 0, image:getWidth() - width, width do
                table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
            end
        end

        animation.duration = duration or 1
        animation.currentTime = 0

        return animation

    end

    -- ==============================================
    --  SOUNDS 
    -- ==============================================
    function sonExplosion()
        explosion = love.audio.newSource("explosion.mp3", "static")
        love.audio.play(explosion)
    end

    function sonRebond()
        rebond = love.audio.newSource("rebond.mp3", "static")
        love.audio.play(rebond)
    end

    function bgmGame()
        bgm = love.audio.newSource("bgm_game.mp3", "stream")
        love.audio.play(bgm)
    end
    function volume()
        volume = love.audio.setVolume(0.05)
    end
end

function Player_1_win()
    if scorePlayer1 >= 7 then
        centreBalle()
        balle.vitesse_x = 0
        balle.vitesse_y = 0

    end
end

function player_1_Point()
    scorePlayer_1 = scorePlayer_1 + 1
end
function player_2_Point()
    scorePlayer_2 = scorePlayer_2 + 1
end

function centreBalle()
    balle.x = love.graphics.getWidth() / 2
    balle.x = balle.x - balle.largeur / 2

    balle.y = love.graphics.getHeight() / 2
    balle.y = balle.y - balle.hauteur / 2

end

-- ==============================================
--  LOAD
-- ==============================================
function loadJeu()

    -- Charger l'image de fond
    background = love.graphics.newImage("background.png")

    -- Initialiser la position de l'image de fond
    backgroundX1 = 0
    backgroundX2 = -background:getWidth()

    -- Initialiser la vitesse de défilement de l'image de fond
    backgroundSpeed = 100
    bgmGame()
    volume()
    centreBalle()
    player = love.graphics.newImage("neonP.png")
    font = love.graphics.newFont("ThaleahFat.ttf", 45, normal)
    animation = newAnimation(love.graphics.newImage("spritesheet.png"), 16, 16, 1)
    rng = love.math.newRandomGenerator()
    rng:setSeed(os.time())
    balle.vitesse_x = rng:random(2, 5) * randomNegativeOrPositive()
    rng:setSeed(os.time())
    balle.vitesse_y = rng:random(2, 5) * randomNegativeOrPositive()

end

-- ==============================================
--  UPDATE
-- ==============================================
function updateJeu(dt)

    animation.currentTime = animation.currentTime + dt
    if animation.currentTime >= animation.duration then
        animation.currentTime = animation.currentTime - animation.duration

    end

    if love.keyboard.isDown("s") and pad.y < love.graphics.getHeight() - pad.hauteur then
        pad.y = pad.y + 4
    end
    if love.keyboard.isDown("z") and pad.y > 0 then
        pad.y = pad.y - 4
    end
    if love.keyboard.isDown("down") and pad2.y < love.graphics.getHeight() - pad2.hauteur then
        pad2.y = pad2.y + 4
    end
    if love.keyboard.isDown("up") and pad2.y > 0 then
        pad2.y = pad2.y - 4
    end
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end

    balle.x = balle.x + balle.vitesse_x
    balle.y = balle.y + balle.vitesse_y

    if balle.x < 0 then
        centreBalle()
        sonExplosion()
        player_2_Point()
        balle.vitesse_x = -2
        balle.vitesse_y = -2
    end

    if balle.y < 0 then
        balle.vitesse_y = balle.vitesse_y * -1
    end
    if balle.x > love.graphics.getWidth() then
        centreBalle()
        sonExplosion()
        player_1_Point()
        balle.vitesse_x = 2
        balle.vitesse_y = 2
    end
    if balle.y > love.graphics.getHeight() - balle.hauteur then
        balle.vitesse_y = balle.vitesse_y * -1
    end

    if balle.x <= pad.x + pad.largeur then
        if balle.y + balle.hauteur > pad.y and balle.y < pad.y + pad.hauteur then
            balle.x = pad.x + pad.largeur
            balle.vitesse_x = balle.vitesse_x * -1
            balle.vitesse_x = balle.vitesse_x + 1
            sonRebond()
        end
    end
    if balle.x + balle.largeur >= pad2.x then
        if balle.y + balle.hauteur > pad2.y and balle.y < pad2.y + pad2.hauteur then
            balle.x = pad2.x - pad2.largeur
            balle.vitesse_x = balle.vitesse_x * -1
            balle.vitesse_x = balle.vitesse_x - 1
            sonRebond()
        end
    end
    -- Mettre à jour la position de l'image de fond en fonction de la vitesse de défilement
    backgroundX1 = backgroundX1 + backgroundSpeed * dt
    backgroundX2 = backgroundX2 + backgroundSpeed * dt

    -- Si la première instance de l'image de fond sort de l'écran, la ramener en haut
    if backgroundX1 > love.graphics.getWidth() then
        backgroundX1 = backgroundX2 - background:getWidth()
    end

    -- Si la deuxième instance de l'image de fond sort de l'écran, la ramener en haut
    if backgroundX2 > love.graphics.getWidth() then
        backgroundX2 = backgroundX1 - background:getWidth()
    end
end

-- ==============================================
--  DRAW
-- ==============================================
function drawJeu()
    love.graphics.rectangle("fill", pad.x, pad.y, pad.largeur, pad.hauteur)
    love.graphics.rectangle("fill", pad2.x, pad2.y, pad2.largeur, pad2.hauteur)
    love.graphics.rectangle("fill", balle.x, balle.y, balle.largeur, balle.hauteur)
    -- Dessiner l'image de fond en deux instances pour remplir l'écran
    love.graphics.draw(background, backgroundX1, 0)
    love.graphics.draw(background, backgroundX2, 0)
    love.graphics.draw(player, pad.x, pad.y)
    love.graphics.draw(player, pad2.x, pad2.y)
    love.graphics.setFont(font)
    love.graphics.print(scorePlayer_1, 370, 24)
    love.graphics.print("Score", 348, 3)
    love.graphics.print(scorePlayer_2, 420, 24)
    local spriteNum = math.floor(animation.currentTime / animation.duration * #animation.quads) + 1
    love.graphics.draw(animation.spriteSheet, animation.quads[spriteNum], balle.x - 34, balle.y - 25, 0, 4)

end
