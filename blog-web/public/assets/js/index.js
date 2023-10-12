var vm;

document.addEventListener("visibilitychange", () => {
    if (document.hidden) {
        //离开此标签页
        document.title = "不要走吗o(>﹏<)o"
    } else {
        //进入此标签页
        document.title = "咦~ 你又回来了O(∩_∩)O哈哈~"

        window.setTimeout(() => {
            document.title = "拾壹博客-一个专注于技术分享的博客平台"
        }, 800)
    }
});

!function (e, t, a) {
    function r() {
        for (var e = 0; e < s.length; e++) s[e].alpha <= 0 ? (t.body.removeChild(s[e].el), s.splice(e, 1)) : (s[e].y--, s[e].scale += .004, s[e].alpha -= .013, s[e].el.style.cssText = "left:" + s[e].x + "px;top:" + s[e].y + "px;opacity:" + s[e].alpha + ";transform:scale(" + s[e].scale + "," + s[e].scale + ") rotate(45deg);background:" + s[e].color + ";z-index:99999");
        requestAnimationFrame(r)
    }
    function n() {
        var t = "function" == typeof e.onclick && e.onclick;
        e.onclick = function (e) {
            t && t(),
                o(e)
        }
    }
    function o(e) {
        var a = t.createElement("div");
        a.className = "heart",
            s.push({
                el: a,
                x: e.clientX - 5,
                y: e.clientY - 5,
                scale: 1,
                alpha: 1,
                color: c()
            }),
            t.body.appendChild(a)
    }
    function i(e) {
        var a = t.createElement("style");
        a.type = "text/css";
        try {
            a.appendChild(t.createTextNode(e))
        } catch (t) {
            a.styleSheet.cssText = e
        }
        t.getElementsByTagName("head")[0].appendChild(a)
    }
    function c() {
        return "rgb(" + ~~(255 * Math.random()) + "," + ~~(255 * Math.random()) + "," + ~~(255 * Math.random()) + ")"
    }
    var s = [];
    e.requestAnimationFrame = e.requestAnimationFrame || e.webkitRequestAnimationFrame || e.mozRequestAnimationFrame || e.oRequestAnimationFrame || e.msRequestAnimationFrame ||
        function (e) {
            setTimeout(e, 1e3 / 60)
        },
        i(".heart{width: 10px;height: 10px;position: fixed;background: #f00;transform: rotate(45deg);-webkit-transform: rotate(45deg);-moz-transform: rotate(45deg);}.heart:after,.heart:before{content: '';width: inherit;height: inherit;background: inherit;border-radius: 50%;-webkit-border-radius: 50%;-moz-border-radius: 50%;position: fixed;}.heart:after{top: -5px;}.heart:before{left: -5px;}"),
        n(),
        r()
}(window, document);


/* 样式代码 */
var styleTitle1 = `
font-size: 20px;
font-weight: 600;
color: rgb(244,167,89);
`
var styleTitle2 = `
font-style: oblique;
font-size:14px;
color: rgb(244,167,89);
font-weight: 400;
`
var styleContent = `
color: rgb(30,152,255);
`

/* 内容代码 */
var title1 = '🌒 拾壹博客 '

// => 读取配置型(在配置文件里配置这些会变动的网址)
var offiUrl = 'https://www.shiyit.com/'
var content = `
版 本 号：1.0    
编译日期：${new Date()}
站点介绍：
1. 一个想当全栈程序员的个人博客.
🏠官网:  ${offiUrl}
📞QQ/VX: 1248954763
`
console.log(`%c${title1}
%c${content}`, styleTitle1, styleContent)

// (function fairyDustCursor() {

//     var possibleColors = ["#D61C59", "#E7D84B", "#1B8798"]
//     var width = window.innerWidth;
//     var height = window.innerHeight;
//     var cursor = { x: width / 2, y: width / 2 };
//     var particles = [];

//     function init() {
//         bindEvents();
//         loop();
//     }

//     // Bind events that are needed
//     function bindEvents() {
//         document.addEventListener('mousemove', onMouseMove);
//         window.addEventListener('resize', onWindowResize);
//     }

//     function onWindowResize(e) {
//         width = window.innerWidth;
//         height = window.innerHeight;
//     }

//     function onMouseMove(e) {
//         cursor.x = e.clientX;
//         cursor.y = e.clientY;

//         addParticle(cursor.x, cursor.y, possibleColors[Math.floor(Math.random() * possibleColors.length)]);
//     }

//     function addParticle(x, y, color) {
//         var particle = new Particle();
//         particle.init(x, y, color);
//         particles.push(particle);
//     }

//     function updateParticles() {

//         // Updated
//         for (var i = 0; i < particles.length; i++) {
//             particles[i].update();
//         }

//         // Remove dead particles
//         for (var i = particles.length - 1; i >= 0; i--) {
//             if (particles[i].lifeSpan < 0) {
//                 particles[i].die();
//                 particles.splice(i, 1);
//             }
//         }

//     }

//     function loop() {
//         requestAnimationFrame(loop);
//         updateParticles();
//     }

//     /**
//      * Particles
//      */
//     function Particle() {

//         this.character = "*";
//         this.lifeSpan = 120; //ms
//         this.initialStyles = {
//             "position": "fixed",
//             "display": "inline-block",
//             "top": "0px",
//             "left": "0px",
//             "pointerEvents": "none",
//             "touch-action": "none",
//             "z-index": "10000000",
//             "fontSize": "25px",
//             "will-change": "transform"
//         };

//         // Init, and set properties
//         this.init = function (x, y, color) {

//             this.velocity = {
//                 x: (Math.random() < 0.5 ? -1 : 1) * (Math.random() / 2),
//                 y: 1
//             };

//             this.position = { x: x + 10, y: y + 10 };
//             this.initialStyles.color = color;

//             this.element = document.createElement('span');
//             this.element.innerHTML = this.character;
//             applyProperties(this.element, this.initialStyles);
//             this.update();

//             document.querySelector('.js-cursor-container').appendChild(this.element);
//         };

//         this.update = function () {
//             this.position.x += this.velocity.x;
//             this.position.y += this.velocity.y;
//             this.lifeSpan--;

//             this.element.style.transform = "translate3d(" + this.position.x + "px," + this.position.y + "px, 0) scale(" + (this.lifeSpan / 120) + ")";
//         }

//         this.die = function () {
//             this.element.parentNode.removeChild(this.element);
//         }

//     }

//     /**
//      * Utils
//      */
//     // Applies css `properties` to an element.
//     function applyProperties(target, properties) {
//         for (var key in properties) {
//             target.style[key] = properties[key];
//         }
//     }

//     if (!('ontouchstart' in window || navigator.msMaxTouchPoints)) init();
// })();