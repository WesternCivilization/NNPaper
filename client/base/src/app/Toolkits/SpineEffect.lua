-------------------------------------------------------------
-- spine 骨骼动画

SpineEffect = class("SpineEffect")

--特效一次性，播放完后，直接释放
function SpineEffect:ctor(name, parent, isLoop, preLoad)
    self._rootNode = cc.Node:create()
    
    self._scale = 1
    
    self._isLoop = isLoop or false
    self._preLoad = preLoad or false
    
    parent:addChild(self._rootNode)
    self:createEffect(name)

    self._parent = parent
    self._name = name
end

function SpineEffect:delayPushPool(modelType, modelNode, rootNode)
    -- SpineEffectPool:push(modelType, modelNode)
    rootNode:removeChild(modelNode, false)  --不要清理，下次缓存还会使用

    rootNode:removeFromParent()
end

function SpineEffect:finalize()
   print("=============finalize=============", self._name)
    self:unregisterEventHandler()

    self._parent = nil
    self._rootNode = nil
    self._effectNode = nil
end

function SpineEffect:createEffect(name)
    local json = "base/res/spine/" .. name .. "/".. name ..".json"
    local atlas = "base/res/spine/" .. name .. "/".. name ..".atlas"
    
    self._modelType = name
        
    if self._effectNode == nil then
        print("~~~~~~~~~SpineEffect~~~~创建模型特效~~~~~:"..name)
        self._effectNode = sp.SkeletonAnimation:createWithData(json, atlas)
    end
    
    self._rootNode:addChild(self._effectNode)
    self:registerSpineEventHandler()
    self._effectNode:setAnimation(0, "animation", self._isLoop)
    
    self._effectNode:resume()
end

function SpineEffect:registerSpineEventHandler()
    local function callback(event)
        if event.type == "  " then
            self:unregisterEventHandler()
        end
    end
    self._effectNode:registerSpineEventHandler(callback)
end

function SpineEffect:unregisterEventHandler()
    self._effectNode:unregisterSpineEventHandler()
end

function SpineEffect:setPosition(x, y)
    self._rootNode:setPosition(x, y)
end

function SpineEffect:setLocalZorder(zOrder)
    self._rootNode:setLocalZOrder(zOrder)
end

----- 1 , -1
function SpineEffect:setDirection(dir)
    self._dir = dir
    self._rootNode:setScaleX(dir * self._scale)
end

function SpineEffect:setRotation(r)
    self._effectNode:setRotation(r)
end
