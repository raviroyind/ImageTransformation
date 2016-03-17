Imports System.Drawing
Imports System.IO
Imports System.Net

Public Class ProcessImg
    Inherits System.Web.UI.Page
    'Specify Image Virtual Path here
     Private Const FilePath As String = "source.png"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Request.QueryString("lineangle") IsNot Nothing Then
	        ProcessImage(FilePath, Convert.ToInt32(Request.QueryString("lineangle")))
        End If
    End Sub

    Private Sub ProcessImage(fileIn As String, lineangle As Integer)

        Dim sourceImage = System.Drawing.Image.FromFile(Server.MapPath(fileIn))
    	Dim x = sourceImage.Width / 2
	    Dim y = sourceImage.Height / 2
	    Const  lineWidth As Integer = 5

	Using g = Graphics.FromImage(sourceImage)
		g.TranslateTransform(x, y)
		g.RotateTransform(lineangle)
		g.TranslateTransform(-x, -y)
		g.DrawLine(New Pen(Color.Black, Convert.ToSingle(lineWidth)), New Point(x, 0), New Point(x, y))
	End Using
    
    'Write Image to response.
	Response.Clear()
	Response.StatusCode = CType(HttpStatusCode.OK, Integer)
	Response.ContentType = "image/png"
	Dim responseImage As Byte() = ImageToByteArray(sourceImage)
	Response.BinaryWrite(responseImage)
	Response.Flush()

End Sub

Public Function ImageToByteArray(imageIn As System.Drawing.Image) As Byte()
	Dim ms As New MemoryStream()
	imageIn.Save(ms, System.Drawing.Imaging.ImageFormat.Gif)
	Return ms.ToArray()
End Function

End Class