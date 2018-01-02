-- 游戏轮播图
local PageViewLayer = class("PageViewLayer", ccui.PageView)

local ClientUpdate = appdf.req(appdf.BASE_SRC.."app.controllers.ClientUpdate")

-- local ExternalFun = appdf.req(appdf.EXTERNAL_SRC .. "ExternalFun")

function PageViewLayer:ctor(scene)
    print("============= 游戏轮播图界面创建 =============")

    self._scene = scene
    self:setDirection(ccui.ScrollViewDir.horizontal)
end



--PageView事件
PAGEVIEW_EVENT_TYPE = 
{
   TURNING = 0,  
}
 
--当前显示的页码(1 ~ pages)
local pageIdx = 1
 
--英雄列表(id)
-- local heroList = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18}
local heroList = {1, 2, 3, 4}
 
--------------------------------------------------------------------------------------------------------------------
-- 功能方法
 
-- --pIdx:     该页显示的内容索引(1 ~ pages)
-- --iIdx:     插入位置
-- --bClone:   是否克隆, 第一页已存在为false, 否则为true 
-- function PageViewLayer:addOnePage(pIdx, iIdx, bClone)
 
--     local newPage = nil
--     if not bClone then
--         newPage = self:getItem(0)
--     else
--         newPage = self:getItem(0):clone()
--     end

--     if newPage == nil then
--         print("居然是空的的  "..pIdx)
--         self:insertPage(self:initPageInfo(),0)
--         newPage = self:getItem(0)
--         newPage:setTag(0)
--         return
--     end

--     newPage:setTag(pIdx)
--     self:insertPage(newPage, iIdx)
 
--     -- --根据pIdx设置武将信息(每个页面有6个武将)
--     -- for i = 1, 6 do
--     --     -----
--     -- end
 
-- end

-- 页面详细信息
function PageViewLayer:initPageInfo()
    local size = self:getContentSize()
 
    local pageLayout = ccui.Layout:create()
    pageLayout:setContentSize(size)
    -- pageLayout:setBackGroundColor(cc.c3b(0, 0, 0)
    -- pageLayout:setBackGroundColorOpacity(100)
    -- -- pageLayout:setBackGroundColorType(LAYOUT_COLOR_SOLID)
    -- pageLayout:setPosition(260,420)
    -- pageLayout:setAnchorPoint(0,0)


    -- --游戏图标按钮
    local btnurl = "notice.png"
    local btnGameIcon = cc.Sprite:createWithSpriteFrameName(btnurl)
            :setPosition(size.width/2,size.height/2)
            :addTo(pageLayout)


    --     --游戏图标按钮
    --         -- local btnGameIcon = ccui.Button:create(btnurl,btnurl,btnurl)
    --         -- btnGameIcon:setPosition(size.width/2,size.height/2)
    --         -- btnGameIcon:addTo(pageLayout)
    --         -- btnGameIcon:selftTouchEnabled(true)
    --         btnGameIcon:addTouchEventListener(function(ref, type)

    --             --改变按钮点击颜色
    --             if type == ccui.TouchEventType.began then
    --                 ref:setColor(cc.c3b(200, 200, 200))
    --             elseif type == ccui.TouchEventType.ended or ccui.TouchEventType.canceled then
    --                 ref:setColor(cc.WHITE)
    --             end
    --         end)
    --         btnGameIcon:addClickEventListener(function()

    --             -- self:onClickGame(self._gameList[i])
    --         end)
           

    -- local btnGameIcon = ccui.ImageView:create()
    -- btnGameIcon:loadTexture(btnurl)
    -- btnGameIcon:setPosition(size.width/2,size.height/2)
    -- btnGameIcon:addTo(pageLayout)
    -- btnGameIcon:setTouchEnabled(true)
    -- btnGameIcon:setSwallowTouches(false)
    -- btnGameIcon:addTouchEventListener(function(ref, tType)
    --     --改变按钮点击颜色
    --     if type == ccui.TouchEventType.began then
    --         ref:setColor(cc.c3b(200, 200, 200))
    --     elseif type == ccui.TouchEventType.ended or ccui.TouchEventType.canceled then
    --         ref:setColor(cc.WHITE)
    --     end
    -- end)





    -- self:registerTouch(pageLayout)

    return pageLayout
end
 
-- function PageViewLayer:registerTouch(pageLayout)
--     local function onTouchBegan( touch, event )
--         return self:isVisible()
--     end

--     local function onTouchEnded( touch, event )
--         -- local pos = touch:getLocation()
--         showToast(nil, "点击了了了流量",2)
--         -- local m_spBg = self.m_spBg
--         -- pos = m_spBg:convertToNodeSpace(pos)
--         -- local rec = cc.rect(0, 0, m_spBg:getContentSize().width, m_spBg:getContentSize().height)
--         -- if false == cc.rectContainsPoint(rec, pos) then
--         --     self:setVisible(false)
--         -- end        
--     end

--     local listener = cc.EventListenerTouchOneByOne:create()
--     listener:setSwallowTouches(true)
--     self.listener = listener
--     listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
--     listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
--     local eventDispatcher = self:getEventDispatcher()
--     eventDispatcher:addEventListenerWithSceneGraphPriority(listener, pageLayout)
-- end


function PageViewLayer:updatePageInfo(pageNum)

    --删除原来的页面(第一页保留用于clone)
    for i = (#self:getItems() - 1), 1, -1 do
        self:removePageAtIndex(i) 
    end
     
    --添加新的页面(每页显示6个)
    local pages = pageNum or 1
 
    pageIdx = 1

    for i=1,pages do
        self:insertPage(self:initPageInfo(),i-1)
    end

end
 
function PageViewLayer:onPageViewEvent(sender, eventType)
    
    showToast(nil,"翻页！！！",2)

    if eventType == PAGEVIEW_EVENT_TYPE.TURNING then
 
        -- local pages = math.ceil(table.nums(heroList) / 6)
        local pages = 4
 
        if pages >= 3 then
            if 0 == self:getCurPageIndex() then
 
                pageIdx = pageIdx - 1
                if pageIdx <= 0 then
                    pageIdx = pages
                end
 
                local nextPageIdx = pageIdx - 1
                if nextPageIdx <= 0 then
                    nextPageIdx = pages
                end
 
                self:removePageAtIndex(2)
                -- self:addPageToHeroPanel(nextPageIdx, 0, true)
                 
 
                --PageView的当前页索引为0,在0的位置新插入页后原来的页面0变为1;
                --PageView自动显示为新插入的页面0,我们需要显示为页面1,所以强制滑动到1.
                self:scrollToPage(1)
                --解决强制滑动到1后回弹效果
                -- self:update(10)   
 
            elseif 2 == self:getCurPageIndex() then
 
                pageIdx = pageIdx + 1
                if pageIdx > pages then
                    pageIdx = 1
                end
 
                local nextPageIdx = pageIdx + 1
                if nextPageIdx > pages then
                    nextPageIdx = 1
                end
 
                self:removePageAtIndex(0)
                -- self:addPageToHeroPanel(nextPageIdx, 2, true)
 
            end
        elseif pages == 2 then
            if 0 == self:getCurPageIndex() then
 
                local nextPageIdx = 0
                if 1 == pageIdx then
                    pageIdx = 2
                    nextPageIdx = 1
                else
                    pageIdx = 1
                    nextPageIdx = 2
                end
 
                self:removePageAtIndex(2)
                -- self:addPageToHeroPanel(nextPageIdx, 0, true)
                 
                --PageView的当前页索引为0,在0的位置新插入页后原来的页面0变为1;
                --PageView自动显示为新插入的页面0,我们需要显示为页面1,所以强制滑动到1.
                self:scrollToPage(1)
                --解决强制滑动到1后回弹效果
                -- self:update(10)   
 
            elseif 2 == self:getCurPageIndex() then
 
                local nextPageIdx = 0
                if 1 == pageIdx then
                    pageIdx = 2
                    nextPageIdx = 1
                else
                    pageIdx = 1
                    nextPageIdx = 2
                end
 
                self:removePageAtIndex(0)
                -- self:addPageToHeroPanel(nextPageIdx, 2, true)
 
            end
        end
    end
 
end



return PageViewLayer
