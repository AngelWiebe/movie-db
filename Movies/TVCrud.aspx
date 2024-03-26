<%@ Page Title="" Language="C#" MasterPageFile="~/TVShows.Master" AutoEventWireup="true" CodeBehind="TVCrud.aspx.cs" Inherits="Movies.TVCrud" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            height: 44px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <asp:DropDownList ID="ddlShows" runat="server" Height="44px" Width="180px"></asp:DropDownList>
    <asp:Button ID="btnDelete" CssClass="button" runat="server" Text="Delete" OnClick="btnDelete_Click" />
    <br />
    <br />
    <asp:Button ID="btnView" CssClass="button" runat="server" Text="View" OnClick="btnView_Click"/>
    <asp:Button ID="btnNew" CssClass="button" runat="server" Text="New" OnClick="btnNew_Click" />
    <br />
    <asp:Panel ID="pnlContents" runat="server" Visible="false" CssClass="Right">        
        <asp:Image ID="imgShow" runat="server" Height="448px" Width="282px" CssClass="Left" />
        <asp:HiddenField ID="hfShowID" runat="server" />
        <div>
            <table>
                <tr><td class="auto-style1"></td></tr>
                <tr>
                    <td>Show Name:
                    </td>
                    <td>
                        <asp:TextBox ID="txtShowName" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvShowName" ControlToValidate="txtShowName" runat="server" ErrorMessage="Please Enter a Show Name" EnableClientScript="False"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Number Of Seasons:
                    </td>
                    <td>
                        <asp:TextBox ID="txtNumberOfSeasons" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td>Plot:
                    </td>
                    <td>
                        <asp:TextBox ID="txtPlot" runat="server" TextMode="MultiLine" Height="148px" Width="188px"></asp:TextBox>
                    </td>
                </tr>
                                <tr>
                    <td>Concluded:
                    </td>
                    <td>
                        <asp:RadioButton ID="rbYes" runat="server" Text="Yes" GroupName="Concluded" Checked="true" />
                        <asp:RadioButton ID="rbNo" runat="server" Text="No" GroupName="Concluded" />
                    </td>
                </tr>
                <tr>
                    <td>Upload A New Image: 
                    </td>
                    <td>
                        <asp:CheckBox ID="cbNewImage" Checked="false" runat="server" AutoPostBack="true" />
                    </td>
                </tr>
                <asp:Panel ID="pnlNewImage" runat="server" Visible="false">
                    <tr>
                        <td>Image:
                        </td>
                        <td>
                            <asp:FileUpload ID="fulImage" runat="server"/>
                        </td>
                    </tr>
                </asp:Panel>
            </table>
            <asp:Button ID="btnSave" CssClass="button" runat="server" Text="Save" OnClick="btnSave_Click"/>
            <asp:Button ID="btnCancel" CssClass="button" runat="server" Text="Cancel" OnClick="btnCancel_Click"/>
        </div>
    </asp:Panel>
    <br />
</asp:Content>