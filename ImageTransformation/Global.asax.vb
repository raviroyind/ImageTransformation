
Public Class Global_asax
    Inherits HttpApplication

    Sub Application_Start(sender As Object, e As EventArgs)
        ' Fires when the application is started
        'ScriptManager.ScriptResourceMapping.AddDefinition("jquery", New ScriptResourceDefinition() With { _
	       ' .Path = "~/scripts/jquery-1.8.1.min.js", _
	       ' .DebugPath = "~/scripts/jquery-1.8.1.min.js", _
	       ' .CdnPath = "http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.4.1.min.js", _
	       ' .CdnDebugPath = "http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.4.1.js" _
        '})
    End Sub
End Class