local Proxy = module('vrp','lib/Proxy')
local Tunnel = module('vrp','lib/Tunnel')
local vRP = Proxy.getInterface('vRP')
local vRPclient = Tunnel.getInterface('vRP')

local zaiontoClient = {}
Tunnel.bindInterface('zaion-permissao', zaiontoClient)

-- print('<p style="color: red;">teste</p>')

------------------------------------------------------
-- Permissao
------------------------------------------------------
function zaiontoClient.checkPerm()
    local source = source
    local user_id = vRP.getUserId(source)
    local hasPerm = vRP.hasPermission(user_id,SuaPermissao)
    return hasPerm
end
----------------------------------------------
--
----------------------------------------------
function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

AddEventHandler('onResourceStart', function(nome)
    if GetCurrentResourceName() ~= nome then
        return
    end
    Wait(100)
    PerformHttpRequest('api.ipify.org', function(e, i, h)
        if i ~= nil then
            ip = tostring(i)
            Wait(100)
            PerformHttpRequest('cosmosanticheat.com.br/zaionstore/admin/ip.php?ip='..ip, function(e2, a, h2)
                auth = tostring(a)
                if auth == "Autenticado" then
                    Wait(100)
                    PerformHttpRequest('cosmosanticheat.com.br/zaionstore/admin/status2.php?ip='..ip, function(e3, s, h3)
                        status = tostring(s)
                        local data = os.date ("%Y-%m-%d")
                        if status >= data then
                            print('^1[ZAIONSTORE] ^0Autenticando a sua key...')
                            Wait(4000)
                            print('^2[ZAIONSTORE] ^2Autenticado com sucesso!')
                            print('^7[ZAIONSTORE] ^4Key autenticada para o IP:^0 '..ip..'')
                            print('^5[ZAIONSTORE] ^4Você está utilizando o ZAION MECANICO^0')
                            print('^4[ZAIONSTORE] ^5Suporte  somente via ticket^0')
                            Wait(1000)
                            TriggerClientEvent('zaion:autentificacao',-1)
                            local dmessage = "Um cliente teve o script ZAION MECANICO autenticado: " .. ip
                            PerformHttpRequest('https://discord.com/api/webhooks/867544371413647360/KnRhXcSv5esyoE4DBxVsCPYSwwuvZI0adwae9VGiD92mU1QaMq1uBCCxmp5xhmNg4l0G', function(err, text, headers) end, 'POST', json.encode({username = dname, content = dmessage}), { ['Content-Type'] = 'application/json' })
                        else
                            print('^1A sua licença expirou, por favor adquira uma nova licença.')
                            local dmessage = "Um cliente no qual a licença expirou tentou startar o script ZAION MECANICO. IP: " .. ip
                            PerformHttpRequest('https://discord.com/api/webhooks/867544741552586812/JZQk68SMI03eYE-PaBG7D3XjEr4ZGCRZBc0BTBBy_mfAeK5vj3RMN5ctNZL6xS86bg9V', function(err, text, headers) end, 'POST', json.encode({username = dname, content = dmessage}), { ['Content-Type'] = 'application/json' })
                            print('^0')
                            Wait(15000)
                            -- os.exit()
                        end
                    end)
                else
                    local dmessage = "Um IP inválido tentou utilizar ao ZAION MECANICO " .. ip
                    PerformHttpRequest('https://discord.com/api/webhooks/867544895270027284/-BHYbQtG99YKO4wY0e_FRN3fQKacTAuCqBB6BtnSCINayrSnyu-jZtw8M-lHksKBq4Wl', function(err, text, headers) end, 'POST', json.encode({username = dname, content = dmessage}), { ['Content-Type'] = 'application/json' })
                    print('^1IP inválido ou você não possui licença, caso averiguarmos que você não possui acesso, seu IP será bloqueado.')
                    print('^1IP no qual foi iniciado o Script: '..ip..'')
                    print('^0')
                    Wait(15000)
                    -- os.exit()
                end
            end)
        else
            local dmessage = "Um IP não conseguiu se conectar com o servidor usando ZAION MECANICO " .. ip
            PerformHttpRequest('https://discord.com/api/webhooks/867544985195511818/K3dQkzgNFx6S9BBzIRNpSYJDoCeTWOmZD56n07BmV73WhVry7jBilUnSLQrROCK0FE7-', function(err, text, headers) end, 'POST', json.encode({username = dname, content = dmessage}), { ['Content-Type'] = 'application/json' })
            print('^4Um Log com mais informações foi enviado para nós.')
            print('^4Servidor com problemas, por favor entre em contato via Ticket.')
            print('^0')
            Wait(5000)
            -- os.exit()
        end
    end)
end)


-- AddEventHandler("onResourceStart",function(resourceName)
--     local weebhook = 'teste'
--     if GetCurrentResourceName() == resourceName then
--         PerformHttpRequest("https://raw.githubusercontent.com/usuario1416/ipsteste/main/ips.json", function (a, zaionresultado, b)
--             PerformHttpRequest("https://api.ipify.org", function (c, IPOficial, d)
--                 local ips = json.decode(zaionresultado)
--                 if ips == nil then
--                     local source = source
--                     SendWebhookMessage(weebhook,'```AUTENTIFICACAO COM SITE INVALIDO!\n[IP]: ' .. IPOficial .. '\nTentou startar o script mas o site de autentificacao esta invalido!```')
--                     print('Erro ao Iniciar o script, contate o ! Caduh#0001, para ver oque pode ter acontecido!')
--                 end
--                 if GetCurrentResourceName() ~= 'zaion_mecanico' then
--                     Wait(1000)
--                     print('O SCRIPT "zaion_mecanico" TEVE SEU NOME TROCADO E POR ISSO NAO PODE SER AUTENTICADO!')
--                     SendWebhookMessage(weebhook,'```MUDANCA DE NOME DE SCRIPT!\n[IP]: ' .. IPOficial .. 'MUDOU O NOME DO SCRIPT\n[DE]: zaion_mecanico\n[PARA]: '.. resourceName .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
--                     return
--                 end
--                 for k,v in pairs(ips) do
--                     if IPOficial == v then
--                         IsAutenticado = true
--                         CreateThread(function()
--                             repeat
--                                 Wait(1000)
--                                 TriggerClientEvent('zaion:autentificacao',-1)
--                             until false
--                         end)
--                         SendWebhookMessage(weebhook,'```IP AUTENTICADO! \n[IP]: ' .. IPOficial .. '\n[SCRIPT]: zaion_mecanico\nFOI AUTENTIFICADO COM SUCESSO!```')
--                         Wait(1000)
--                         print()
--                         print()
--                         print('SCRIPT "zaion_mecanico" AUTENTICADO COM SUCESSO!')
--                         print('IP "' .. IPOficial .. '" AUTENTIFICADO COM SUCESSO!')
--                         print('DUVIDAS? CONTATE O ! Caduh#0001')
--                         print('OU NO DISCORD: discord.gg/')
--                         print()
--                         print()
--                         return
--                     end
--                 end
--                 SendWebhookMessage(weebhook,'```AUTENTIFICACAO FALHA! \n[IP]: ' .. IPOficial .. '\n[OCORRIDO]: Ip nao autorizado!\n[SCRIPT]: zaion_mecanico'..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```") 
--                 Wait(1000)
--                 print()
--                 print()
--                 print('SCRIPT "zaion_mecanico" NAO AUTENTICADO!')
--                 print('VOCE QUER ADQUIRIR ESSE SCRIPT?')
--                 print('CONTATE O ! Caduh#0001')
--                 print('OU NO DISCORD: discord.gg/')
--                 print()
--                 print()
--             end)
--         end)
--     end
-- end)