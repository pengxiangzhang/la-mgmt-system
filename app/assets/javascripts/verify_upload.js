function ValidateExtension() {
    var allowedFiles = [".pdf",];
    var fileUpload = document.getElementById("file");
    var regex = new RegExp("([a-zA-Z0-9\s_\\.\-:])+(" + allowedFiles.join('|') + ")$");
    if (fileUpload.value != "") {
        if (!regex.test(fileUpload.value.toLowerCase())) {
            alert("Please upload files having extensions:" + allowedFiles.join(', ') + " only.");
            fileUpload.value = ''
            return false;
        }
        // Check if any file is selected.
        if (fileUpload.files.length > 0) {
            for (var i = 0; i <= fileUpload.files.length - 1; i++) {
                const fsize = fileUpload.files.item(i).size;
                const file = Math.round((fsize / 1)) / 1024 / 1024;
                // The size of the file.
                if (file >= 4096) {
                    alert(
                        "File too Big, please select a file less than 4mb");
                    fileUpload.value = ""
                    return false
                }
            }
        }
    }
    loading()
    return true;
}