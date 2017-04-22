/**
 * 
 */

var intv;
var current = 0;
var sIdx = 0;
var sCnt =  4;
    
 
function startTopSlider() {
    intv = setInterval(function () {
        $("#ul_btns").find("a").eq(current++ % sCnt).click();
    }, 3000);
}
 
function setBnr(idx, bnr, allTab, addCls) {
    $(bnr).css("visibility", "hidden").eq(idx).css("visibility", "visible");
    $(allTab).removeClass(addCls);
    $(allTab).eq(idx).addClass(addCls);
}
 
$(document).ready(function () {
    
    //set init
$("#top_0").css("visibility", "visible");
$("#btn_0").addClass("on");
startTopSlider();
    
    
$("#ul_btns").find("a").click(function(){
    var idx = $(this).attr("id").split("_")[1];
    setBnr(idx, "#TopSlider > div" , "#ul_btns > a" , "on" );      
    });        
});