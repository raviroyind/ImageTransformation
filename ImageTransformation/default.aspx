<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="default.aspx.vb" Inherits="ImageTransformation._default" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script src="Scripts/jquery-1.8.1.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdateProgress ID="updProgress"
        AssociatedUpdatePanelID="UpdatePanel1"
        runat="server">
        <ProgressTemplate>
            <div id="spinner" class="divspinner">
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <asp:UpdatePanel runat="server" ID="UpdatePanel1">
        <Triggers>
            <asp:PostBackTrigger ControlID="btnSubmit" />
        </Triggers>
        <ContentTemplate>
            <div class="ui fullscreen modal">
                <i class="close icon"></i>
                <div class="header">
                </div>
                <div class="content">
                    <div id="divImage" style="width: 100%;" runat="server"></div>
                </div>
                <div class="actions">
                    <div class="ui button" onclick="$('.fullscreen.modal').modal('hide');">Close</div>
                </div>
            </div>
            <div class="ui grid">
                <div class="one wide column"></div>
                <div class="fourteen wide column">
                    <div class="ui centered">
                        <div class="ui large form container">
                            <div class="ui stacked segment frmPad">
                                <div class="ui form">
                                    <h4 class="ui dividing header orange"><i class="signup icon"></i>Select Image</h4>
                                    <asp:ValidationSummary runat="server" ValidationGroup="upload" DisplayMode="BulletList" ShowMessageBox="False"
                                        CssClass="frmErrors" ShowSummary="True" />

                                    <div class="field">
                                        <asp:FileUpload runat="server" ID="fileImg" />

                                        <asp:RequiredFieldValidator ID="requiredFieldValidatorFile" ValidationGroup="upload"
                                            ErrorMessage="Please select an image" Text="!" ControlToValidate="fileImg"
                                            runat="server" Display="Dynamic" ForeColor="White" />

                                        <asp:RegularExpressionValidator ID="regularExpressionValidatorFileType" ValidationGroup="upload"
                                            ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w].*))+(.gif|.jpeg|.jpg|.png)$"
                                            ControlToValidate="fileImg" runat="server" ForeColor="White" Text="!" ErrorMessage="Please select a valid image file."
                                            Display="Dynamic" />
                                    </div>
                                   
                                    <br/>
                                    <div class="field">
                                        <label>Degrees rotation (angle)</label>
                                        <asp:TextBox runat="server" ID="txtAngel" placeholder="angel of rotation" MaxLength="4"
                                            onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" Width="130">
                                        </asp:TextBox>
                                        <span id="error" style="color: Red; display: none">* Input digits (0 - 9)</span>
                                        <asp:RangeValidator runat="server" ID="rangeValidatorRotation" ControlToValidate="txtAngel"
                                            MinimumValue="0" MaximumValue="360" Type="Integer" ValidationGroup="upload" ErrorMessage="Rotation should be between 0 to 360."></asp:RangeValidator>
                                    </div>
                                     <br/>
                                    
                                    <div class="field">
                                        <label>Line Width</label>
                                        <asp:DropDownList runat="server" ID="ddlLineWidth" CssClass="ui selection dropdown">
                                            <Items>
                                                <asp:ListItem Text="---SELECT---" Value="SEL" Selected="True"></asp:ListItem>
                                                <asp:ListItem Text="1px" Value="1"></asp:ListItem>
                                                <asp:ListItem Text="2px" Value="2"></asp:ListItem>
                                                <asp:ListItem Text="3px" Value="3"></asp:ListItem>
                                                <asp:ListItem Text="4px" Value="4"></asp:ListItem>
                                                <asp:ListItem Text="5px" Value="5"></asp:ListItem>
                                                <asp:ListItem Text="6px" Value="6"></asp:ListItem>
                                                <asp:ListItem Text="7px" Value="7"></asp:ListItem>
                                                <asp:ListItem Text="8px" Value="8"></asp:ListItem>
                                                <asp:ListItem Text="9px" Value="9"></asp:ListItem>
                                                <asp:ListItem Text="10px" Value="10"></asp:ListItem>
                                                <asp:ListItem Text="11px" Value="11"></asp:ListItem>
                                                <asp:ListItem Text="12px" Value="12"></asp:ListItem>
                                                <asp:ListItem Text="13px" Value="13"></asp:ListItem>
                                                <asp:ListItem Text="14px" Value="14"></asp:ListItem>
                                                <asp:ListItem Text="15px" Value="15"></asp:ListItem>
                                            </Items>
                                            </asp:DropDownList>
                                    </div>

                                    <div class="field">
                                        <label>Line Color</label>
                                        <asp:TextBox ID="txtColor" runat="server" Width="150px" />
                                        <asp:LinkButton ID="btnColor" CssClass="ui button tiny" runat="server" CausesValidation="False">
                                            <i class="eyedropper icon small orange"></i>
                                        </asp:LinkButton>
                                        <br />
                                        <div id="preview" style="width: 70px; height: 70px; border: 1px solid #dcdcdc; margin: 0 3px; float: left; padding: 20px;">
                                        </div>
                                        <ajaxToolkit:ColorPickerExtender ID="ColorPicker1" runat="server"
                                            TargetControlID="txtColor"
                                            SampleControlID="preview"
                                            PopupButtonID="btnColor"
                                            PopupPosition="Right"
                                            OnClientColorSelectionChanged="Color_Changed" />
                                    </div>
                                    <div class="ui divider"> </div>
                                     <br/>
                                    <div class="field center floated">
                                        <asp:LinkButton ID="btnSubmit" runat="server" CssClass="ui center floated button blue" ValidationGroup="upload" CausesValidation="True" TabIndex="0" OnClick="btnSubmit_OnClick">
                                            <i class="setting icon large"></i>Process
                                        </asp:LinkButton>

                                        <asp:LinkButton ID="btnReset" runat="server" CausesValidation="False" CssClass="ui center floated button" TabIndex="1" OnClick="btnReset_OnClick">
                                           <i class="refresh icon large"></i> Reset
                                        </asp:LinkButton>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="one wide column"></div>

                <div class="one wide column"></div>
                <div class="fourteen wide column" style="margin-bottom: 100px;">
                    <div class="ui centered">
                        <div class="ui large form container">
                            <div class="ui stacked segment frmPad">
                                <div class="ui form">
                                    <label>Click to Zoom</label>
                                    <asp:Image runat="server" Visible="False" Style="width: 100%; cursor: pointer;" ID="imgFinal" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="one wide column"></div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <script type="text/javascript" src="Scripts/semantic.min.js"></script>
    <script type="text/javascript">
        var specialKeys = new Array();
        specialKeys.push(8); //Backspace
        function IsNumeric(e) {
            var keyCode = e.which ? e.which : e.keyCode
            var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1);
            document.getElementById("error").style.display = ret ? "none" : "inline";
            return ret;
        }

        function Color_Changed(sender) {
            sender.get_element().value = "#" + sender.get_selectedColor();
        }

        $(document).on('click', "#MainContent_imgFinal", function () {
            $('.fullscreen.modal').modal('show');
        });

        $('.ui.selection.dropdown').dropdown();
    </script>
</asp:Content>
