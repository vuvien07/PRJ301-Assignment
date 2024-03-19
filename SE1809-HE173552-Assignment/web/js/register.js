/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

function checkPassword(event) {
    var pass = document.getElementById('password').value;
    var re_pass = document.getElementById('re-password').value;
    if (pass === re_pass) {
        window.location.href = 'sign-up';
    } else {
        document.getElementById('error').innerHTML = '<h1 class="output">Sign up failed!</h1>';
        event.preventDefault();
    }
}

function displayMajor(){
    var role = document.getElementById('role').value;
    if(role == 1)
        document.getElementById('select-major').style.display = 'none';
    else document.getElementById('select-major').style.display = 'inline';
}

function changeNavbar(){
    window.location.href = 'login';
}