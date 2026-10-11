-- ALT11 nfqws1 -> nfqws2 compatibility dispatch.
-- Requires zapret-lib.lua and zapret-antidpi.lua from v0.9.4.7 (Lua API 5).
-- TCP ts fooling affects fakes only; real segments retain their timestamps.
-- Numeric pos markers remain zero-based. C converts marker 1 to Lua index 2.
-- GPL-2.0-or-later. This file uses the upstream fake/multisplit functions.

ALT11_PORT_VERSION = "1.0.3"

local function alt11_call(ctx, desync, fn, args)
    local old = desync.arg
    desync.arg = args
    local result = fn(ctx, desync)
    desync.arg = old
    return result
end

local function alt11_csv(value)
    local result = {}
    for item in string.gmatch(value or "", "[^,]+") do
        result[#result+1] = item
    end
    return result
end

function alt11_tcp(ctx, desync)
    if not desync.dis.tcp then return end
    direction_cutoff_opposite(ctx, desync)
    if not direction_check(desync) then return end
    local a = desync.arg
    local payload = desync.l7payload
    local fake_blobs
    if payload == "tls_client_hello" then
        fake_blobs = alt11_csv(a.tls)
    elseif payload == "http_req" then
        fake_blobs = alt11_csv(a.http)
    elseif a.any == "1" and #desync.dis.payload > 0 then
        fake_blobs = alt11_csv(a.unknown)
    else
        return
    end
    for _, name in ipairs(fake_blobs) do
        alt11_call(ctx, desync, fake, {
            blob = name, repeats = a.repeats or "8", payload = "all",
            tcp_ts = "-600000", tcp_ts_up = "1", ip_id = a.ip_id or "seq"
        })
    end
    -- The repeat count belongs to fakes, not to the real split segments.
    return alt11_call(ctx, desync, multisplit, {
        pos = "1", seqovl = a.seqovl, seqovl_pattern = a.pattern,
        payload = "all", repeats = "1", tcp_ts_up = "1", ip_id = a.ip_id or "seq"
    })
end

function alt11_udp(ctx, desync)
    if not desync.dis.udp then return end
    direction_cutoff_opposite(ctx, desync)
    if not direction_check(desync) then return end
    local a = desync.arg
    local p = desync.l7payload
    local name
    local zero64 = "0x" .. string.rep("00", 64)
    local zero620 = "0x" .. string.rep("00", 620)
    if a.mode == "discord" then
        if p == "discord_ip_discovery" or p == "stun" then name = a.active end
    elseif p == "quic_initial" then
        -- Only the two UDP/443 profiles override nfqws1's 620-zero default.
        name = a.mode == "quic" and a.quic or zero620
    elseif p == "wireguard_initiation" or p == "dht" or p == "discord_ip_discovery" or p == "stun" then
        name = zero64
    elseif a.mode == "game" and #desync.dis.payload > 0 then
        name = a.active
    end
    if name then
        return alt11_call(ctx, desync, fake, {
            blob = name, repeats = a.repeats or "11", payload = "all", ip_id = "seq"
        })
    end
end
