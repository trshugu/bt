/*
*/
$(document).ready(function() {
	$("#tmp");
});














/*
// BSD/オールマンでクロージャを使ったときの挙動
function newCounter() {
	var i = 0;
	return function() { // 無名関数
		i = i + 1;
		return i;
	}
}
 
c1 = newCounter();
document.write(c1() + "<br>")
document.write(c1() + "<br>")
document.write(c1() + "<br>")

function newCounterAllman()
{
	var i = 0;
	return function() // 無名関数
	{
		i = i + 1;
		return i;
	}
}
 
d1 = newCounterAllman();
document.write(d1() + "<br>")
document.write(d1() + "<br>")
document.write(d1() + "<br>")
*/


/*
// 配列でfor-inを使うと、prototypeを変更したとき挙動がおかしくなることがある
Object.prototype.hoge = function() {};

var assoc = {
	foo: 1,
	bar: 2,
	baz: 3
};

for ( var i in assoc ) {
	// よってhasOwnProperty()で自分自身のメンバ変数かを確認する
	if ( assoc.hasOwnProperty(i) === true ) {
		document.write(i + assoc[i] + "<br>");
	}
}
*/


/*
// draggable
$(document).ready(function() {
	$("#tmp").draggable({ distance: 20 });
});
*/

/*
// prev + next
$(document).ready(function() {
	$(".prev + .next").css("border", "3px solid red");
});
*/

/*
// 名前をセレクタで
$(document).ready(function() {
	$("input[name=ttb]").css("border", "3px solid red");
});
*/

/*
// classを追加する運用だといいという
$(document).ready(function() {
	$(".tmp:odd").css({color: "#f00"}).addClass("odd-view");
});
*/


/*
// css
$(document).ready(function() {
	$("#tmp").css({color: "#f00"});
});

*/


/*
// tmpを使用する運用に
$(document).ready(function() {
	$("#tmp").click( function(){$(this).slideToggle("slow");} );
});

*/


/*
// h4 の次の要素をトグル
$(document).ready(function() {
  $('#navi > h4').click(function(){
    // 引数には開閉する速度を指定します
    $(this).next().slideToggle('slow');
  });
});
*/



/*
// ワンライナーでの記述が可能
javascript:$('.semooh a').hover(function(){ $(this).text('ヌ？'); },function(){ $(this).text('ヌー'); }); 
*/


/*
// jsでBSD/オールマンのテスト
// javascriptでは行が正しく終っていないと判断した場合、暗黙的に;が挿入される
// http://qiita.com/items/9c349ee212caee635997
function allman()
{
var a = 1
return (a == 1)
? "if"
: "else";

}

alert(allman());
*/


/*
// datatable
$(document).ready( function() {
	$("#example").dataTable();
} );
*/


/*
// datatableサンプル
function fnFeaturesInit ()
{
	// Not particularly modular this - but does nicely :-)
	$('ul.limit_length>li').each( function(i) {
		if ( i > 10 ) {
			this.style.display = 'none';
		}
	} );
	
	$('ul.limit_length').append( '<li class="css_link">Show more<\/li>' );
	$('ul.limit_length li.css_link').click( function () {
		$('ul.limit_length li').each( function(i) {
			if ( i > 5 ) {
				this.style.display = 'list-item';
			}
		} );
		$('ul.limit_length li.css_link').css( 'display', 'none' );
	} );
}

$(document).ready( function() {
	fnFeaturesInit();
	$('#example').dataTable( {
		"bJQueryUI": true,
		"sPaginationType": "full_numbers"
	} );
	
	SyntaxHighlighter.config.clipboardSwf = 'media/javascript/syntax/clipboard.swf';
	SyntaxHighlighter.all();
} );
*/

/*
$(document).ready(function(){
    $("#flipbook").turn({
        width: 400,
        height: 300,
        autoCenter: true
    });
});

$(window).bind('keydown', function(e){
    if (e.keyCode==38){
        $('#zoom-viewport').zoom('zoomIn');
    }
    else if (e.keyCode==40){
        $('#zoom-viewport').zoom('zoomOut');
    }
});

$(window).bind('keydown', function(e){
    if (e.keyCode==37)
        $('#flipbook').turn('previous');
    else if (e.keyCode==39)
        $('#flipbook').turn('next');
});
*/


/*
// Zoom のチェック
$(document).ready(function(){
    $('#zoom-viewport').zoom({
        flipbook: $("#flipbook"),
        duration: 600,
        max: 2
        //when: {
        //  doubleTap: function(e){alert(e);},
        //  Tap: function(e){alert(e);}
        //}
    });
});
    
    // $('#zoom-viewport').bind("zoom.doubleTap", function(e){ alert("dd"); })
    //  $('#zoom-viewport').bind("zoom.tap", function(e){ alert("tt"); })
    // $('#zoom-viewport').bind("zoom.change", function(e, change){ alert(change); })
    // $('#zoom-viewport').bind("zoom.resize", function(e){ alert("tt"); })

$(window).bind('keydown', function(e){
    if (e.keyCode==37)
        $('#flipbook').turn('previous');
    else if (e.keyCode==39)
        $('#flipbook').turn('next');
});
*/


/*
// Eventsのチェック
$(document).ready(function(){
    // $("#flipbook").bind("first", function(event){alert("first!!")});
    // $("#flipbook").bind("last", function(event){alert("last!!")});
    // $("#flipbook").bind("start", function(event, pageObj, corner){alert(pageObj.page)});
    // $("#flipbook").bind("end", function(event, pageObj, turned){alert(pageObj.page)});
    // $("#flipbook").bind("missing", function(event, pages){alert("missing!!")});
    // $("#flipbook").bind("turning", function(event, page, view){alert(page)});
    // $("#flipbook").bind("turned", function(event, page, view){alert(page)});
    // $("#flipbook").bind("zooming", function(event, new, current){alert(new)});
});
*/


/*
// Methodsのチェック
$(window).bind('keydown', function(e){
    if (e.keyCode==37)
        // $('#flipbook').turn('previous');
        // $('#flipbook').turn('addPage', $("<div />").html("Loading..."), $("#flipbook").turn("pages")+1);
        // $('#flipbook').turn('center');
        // $('#flipbook').turn('destroy').remove();
        // $('#flipbook').turn('direction', 'rtl');
        // $('#flipbook').turn('display', 'single');
        // $('#flipbook').turn('disable', true);
        // alert($('#flipbook').turn('hasPage', 10));
        // alert($('#flipbook').turn('is'));
        // $('#flipbook').turn('page', 4);// numへ飛ぶ
        // $('#flipbook').turn('pages', 4); // numにする
        // $('#flipbook').turn('peel', 'br');
        // alert($('#flipbook').turn('range'));
        // $('#flipbook').turn('removePage', 2);
        // $('#flipbook').turn('resize');//?
        // $('#flipbook').turn('size', 100, 100);
        // $('#flipbook').turn('next').turn('stop');
        // alert($('#flipbook').turn('version'));
        $('#flipbook').turn('zoom', 0.5);
    else if (e.keyCode==39)
        $('#flipbook').turn('next');
});

*/


/*
$(document).ready(function(){
    $("#flipbook").turn({
        width: 400,
        height: 300,
        autoCenter: true
    });
});

// Propertiesのチェック
$(window).bind('keydown', function(e){
    if (e.keyCode==37)
        // $('#flipbook').turn('previous');
        // alert($('#flipbook').turn('direction'));
        // alert($('#flipbook').turn('animating'));
        // alert($('#flipbook').turn('size').width);
        // alert($('#flipbook').turn('size').height);
        // alert($('#flipbook').turn('options'));
        // alert($('#flipbook').turn('view').join(" and "));
        // alert($('#flipbook').turn('zoom'));
    else if (e.keyCode==39)
        $('#flipbook').turn('next');
});
*/


/*
// 現在動作中かを判定する
function isAnimating() {
    if ($("#flipbook").turn("animating"))
        alert('Animating a page!');
}
*/


/*
// 矢印キーで改ページ
$(window).bind('keydown', function(e){
    if (e.keyCode==37)
        $('#flipbook').turn('previous');
    else if (e.keyCode==39)
        $('#flipbook').turn('next');
});
*/


/*
// optionsのチェック
$(document).ready(function(){
    $("#flipbook").turn({
        width: 400,
        height: 300,
        // acceleration: false,
        // direction: "rtl",
        // duration: 600,
        // gradients: !$.isTouch,
        // elevation: 50,
        // page: 5,
        // when: {
        //  turning: function(event, page, pageobj) {
        //      alert(event);
        //      alert(page); // 動作したページ
        //      alert(pageobj); // 次のセットなど
        //  }
        // },
        autoCenter: true
    });
    //alert($("#flipbook").children().length)
});
*/


/*
// turn.js サイズを指定しないと自動調整される。
$(document).ready(function(){
    $("#flipbook").turn({
        width: 400,
        height: 300,
        autoCenter: true
    });
});
*/

/*
// tmpsにパラメータ test=John をつけて要求し、その要求が正常に完了したとき、レスポンスを表示する。
$.ajax({
  type: "POST",
  url: "tmps",
  data: {test: "John"},
  success: function(msg){
    alert( "Data Saved: " + msg );
  }
});
*/

/*
// クリックしたdivの色を取得しresultに渡す
$(document).ready(function(){
  $("div").click(function () {
    var color = $(this).css("background-color");
    $("#result").html("That div is <span style='color:" + color + ";'>" + color + "</span>.");
  });
});
*/


/*
// divに:を追加したり.klassの色を変えたりクリックして隠したり。
$(document).ready(function(){
  $("div").append(":");
  $(".klass").css("color","#f00");
  $(".klass").click(function(event){
    event.preventDefault();
    $(this).hide("slow");
  });
});
*/


/*
// ウィンドウサイズのリアルタイムな取得
$(document).ready(function(){
    getScreenSize(); // 画面サイズの取得
    getWindowSize(); // ウィンドウサイズの取得
});

//window.onresize=function(){ getWindowSize(); }
window.onresize=getWindowSize;

// 画面サイズを取得する
function getScreenSize() {
    var s = "横幅 = " + window.parent.screen.width + " / 高さ = " + window.parent.screen.height;
    document.getElementById("ScrSize").innerHTML = s;
}

// ウィンドウサイズを取得する
function getWindowSize() {
    var sW,sH,s;
    if (document.all) {
        //Internet Explorer
        sW = document.body.clientWidth;
        sH = document.body.clientHeight;
    } else {
        //Firefox等
        sW = window.innerWidth;
        sH = window.innerHeight;
    }
    s = "横幅 = " + sW + " / 高さ = " + sH;
 
    document.getElementById("WinSize").innerHTML = s;
}
*/


/* 
// each文
$.each([1,2,3], function() {
  document.write(this + 1);
});
*/

