function hide_time() {
    const checkBox = document.getElementById("now");
    const time = document.getElementById("time_col");
    const date = document.getElementById("date_col");
    const time_input = document.getElementById("time");
    const date_input = document.getElementById("date");
    const asap = document.getElementById("asap_col");

    if (checkBox.checked == true) {
        time.style.display = "none";
        date.style.display = "none";
        asap.style.display = "block"
        time_input.required = false;
        date_input.required = false;
        time_input.value = '';
        date_input.value = '';
    } else {
        time.style.display = "block";
        date.style.display = "block";
        asap.style.display = "none"
        time_input.required = true;
        date_input.required = true;
    }
}