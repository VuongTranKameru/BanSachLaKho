//Changing Ad Image
let images = ['image/hoisachgiamgia.jpg', 'image/tuoitredichdang1.jpg', 'image/huucaoco.jpg'];
/* images là string[]
 * Giống với var, let cũng có tính hoisting tuy nhiên lại khác nhau ở chỗ thay vì 
  var được khởi tạo với giá trị là undefined thì let sẽ không có bất kỳ giá trị khởi tạo nào. 
  Điều này dẫn đến việc nếu chúng ta sử dụng biến let trước khi khai báo thì sẽ gặp lỗi Reference Error.*/
var index = 0;
var imgElement = document.getElementById('runningads');

function change() {
    imgElement.src = images[index];
    /*Đưa giá trị mới vào trong imgElement*/
    index > 1 ? index = 0 : index++;
    /*(condition) ? trueVal : falseVal*/
}

var advertise = setInterval(change, 5000);
//Changing Ad Image in sub html
var oimages = ['../image/tuoitredichdang1.jpg', '../image/huucaoco.jpg'];

var oindex = 0;
var oimgElement = document.getElementById('obanner');

function ochange() {
    oimgElement.src = oimages[oindex];
    oindex > 1 ? oindex = 0 : oindex++;
}

var oadvertise = setInterval(ochange, 5000);