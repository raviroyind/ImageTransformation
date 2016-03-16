Imports System.Drawing
Imports System.IO


Public Class _default
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnReset_OnClick(ByVal sender As Object, ByVal e As EventArgs)
        imgFinal.ImageUrl = String.Empty
        imgFinal.Visible = False  
    End Sub

    Protected Sub btnSubmit_OnClick(ByVal sender As Object, ByVal e As EventArgs)
         If fileImg.HasFile Then
             
            Dim random As New Random()
            Dim suffix = random.Next(Integer.MinValue,Integer.MaxValue).ToString()
            Dim fileName = Server.MapPath("~/tempImg/" + Path.GetFileNameWithoutExtension(fileImg.PostedFile.FileName)  & "_"& suffix & Path.GetExtension(fileImg.PostedFile.FileName))
	            fileImg.PostedFile.SaveAs(fileName)
             
               Dim outPut  = ProcessImage(fileName)
                imgFinal.ImageUrl =outPut
	            imgFinal.Visible = True
                divImage.InnerHtml="<img src='"& outPut.Substring(outPut.IndexOf("/", StringComparison.Ordinal)+1) &"' style='width: 100%;'/>"

                ddlLineWidth.ClearSelection()
                txtAngel.Text=String.Empty
                txtColor.Text=String.Empty
                ScriptManager.RegisterStartupScript(Me, Me.[GetType](), Guid.NewGuid().ToString(), "Page_ClientValidate('')", True)
        End If
    End Sub

    Private Function ProcessImage(fileIn As String) As String
	    Dim sourceImage = System.Drawing.Image.FromFile(fileIn)
	    Dim fileName = Path.GetFileName(fileIn)
	    Dim finalPath = Server.MapPath("~/Output/" + fileName)

	    Dim x As Integer = sourceImage.Width / 2
	    Dim y As Integer = sourceImage.Height / 2

        Dim rotation As Integer = 0
        Dim lineWidth As Integer = 5
        Dim color = System.Drawing.Color.Black
            
        If Not String.IsNullOrEmpty(txtColor.Text)
            Try
                color = ColorTranslator.FromHtml(txtColor.Text)
            Catch ex As Exception
            End Try
        End If

        If ddlLineWidth.SelectedIndex <> 0
            Try
                lineWidth = Convert.ToInt32(ddlLineWidth.SelectedValue)
            Catch ex As Exception
            End Try
        End If

        If Not String.IsNullOrEmpty(txtAngel.Text)
            Try
                rotation = Convert.ToInt32(txtAngel.Text)
            Catch ex As Exception
            End Try
        End If


        Using g = Graphics.FromImage(sourceImage)
		    g.TranslateTransform(x, y)
		    g.RotateTransform(rotation)
		    g.TranslateTransform(-x, -y)
             
		    g.DrawLine(New Pen(color, CType(lineWidth, Single)), New Point(x, 0), New Point(x, y))
	End Using

        sourceImage.Save(finalPath)
	    Return "~/Output/" + fileName
End Function
 Private Shared Sub ClearDirectory(path As String)
	 For Each file In Directory.GetFiles(path)
      System.IO.File.Delete(file)
    Next
End Sub

End Class