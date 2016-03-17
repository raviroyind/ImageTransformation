<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="testPage.aspx.vb" Inherits="ImageTransformation.testPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        .centerDiv {
            position: absolute;
            top:0;
            bottom: 0;
            left: 0;
            right: 0;
            margin: auto;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div class="centerDiv">
        <%-- Set angle of rotation here by passing "lineangle" as querystring --%>
       <img src="processImg.aspx?lineangle=360" class="centerDiv" alt="img"/>
    </div>
    </form>
</body>
</html>