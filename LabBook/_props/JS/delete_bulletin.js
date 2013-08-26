var bulletin_id = "";
var request = null;

function post(id) {
    if (window.XMLHttpRequest) {
        try {
            request = new XMLHttpRequest();
        }
        catch (e) {
            request = null;
        }
    }
    else if (window.ActiveXObject) {
        try {
            request = new ActiveXObject("Msxm12.XMLHTTP");
        }
        catch (e) {
            try {
                request = new ActiveXObject("Microsoft.XMLHTTP");
            }
            catch (e) {
                request = null;
            }
        }
    }

    bulletin_id=id;

    id = "DeleteBulletin.aspx?id=" + id;

    request.open("POST", id, true);
    request.onreadystatechange = handle;
    request.send(null);
}

function handle() {
    var text = "";

    if (request.readyState == 4 && request.status == 200) {
        text = request.responseText;
        switch (text) {
            case "1":
                document.getElementById(bulletin_id).style.display = "none";
                break;
            case "0":
                alert("错误！");
                break;
            default:
                break;
        }
        
    }
}