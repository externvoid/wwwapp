// オブジェクトを作成
// Wed, 17 Jan 2018 10:28:51 +0900
const myObject = {
  value: 0,
  show: function() {
    console.log(this.value)
    console.log(`OK`)

    function show() {
      console.log(this.value)
    }
    show()
  }
}
myObject.show()
// JSの行末に;不要、Stringは'OK', or `OK`を使う
// function宣言、var myObj, const myObj宣言と同じ
function myObj2(){
  this.value = 1
  this.show = () => {
    console.log(`OK ${this.value}`)
  }
}

const a = new myObj2
a.show()


// functionリテラル
const MyObj = function(){
  this.value = 10
  this.show = () => {
    console.log(`OK@function literal`)
  }
}

const b = new MyObj
b.show()
// JavaScriptのthisは4種類
