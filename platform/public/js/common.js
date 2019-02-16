var userBox = document.getElementById('uName');
var userInfo = document.getElementById('userInfo');
userInfo.onmouseover = function () {
    userInfo.style.display = 'block';
};
userBox.onmouseover = function () {
    userInfo.style.display = 'block';
};
userInfo.onmouseout = function () {
    userInfo.style.display = 'none';
};
userBox.onmouseout = function () {
    userInfo.style.display = 'none';
};