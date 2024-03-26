<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Movies.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style2 {
            height: 25px;
        }
        .auto-style3 {
            height: 20px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <asp:DropDownList ID="ddlMovieList" runat="server"></asp:DropDownList>
    <asp:Button ID="btnDelete" CssClass="button" runat="server" Text="Delete" OnClick="btnDelete_Click" />
    <br />
    <asp:Button ID="btnView" CssClass="button" runat="server" Text="View" OnClick="btnView_Click" />
    <asp:Button ID="btnNew" CssClass="button" runat="server" Text="New" OnClick="btnNew_Click" />
    <br />
    <asp:Panel ID="pnlContents" runat="server" Visible="false" CssClass="Right">        
        <asp:Image ID="imgMovie" runat="server" Height="448px" Width="282px" CssClass="Left" />
        <asp:HiddenField ID="hfMovieID" runat="server" />
        <div>
            <table>
                <tr><td class="auto-style3"></td><td class="auto-style3"></td>
                </tr>
                <tr>
                    <td>Name:
                    </td>
                    <td>
                        <asp:TextBox ID="txtMovieName" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvMovieName" ControlToValidate="txtMovieName" runat="server" ErrorMessage="Please Enter a Movie Name" EnableClientScript="False"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Genre:
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlGenre" runat="server"></asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>Year Released:
                    </td>
                    <td>
                        <asp:TextBox ID="txtYearReleased" runat="server" TextMode="Number"></asp:TextBox>
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
                    <td>Part Of A Series:
                    </td>
                    <td>
                        <asp:RadioButton ID="rbSeriesYes" runat="server" Text="Yes" GroupName="PartOfASeries" AutoPostBack="true" />
                        <asp:RadioButton ID="rbSeriesNo" runat="server" Text="No" Checked="true" GroupName="PartOfASeries" AutoPostBack="true" />
                    </td>
                </tr>
                <tr>
                    <asp:Panel ID="pnlSeries" runat="server" Visible="false">
                        <td>Which Series:
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlSeries" runat="server"></asp:DropDownList>
                        </td>
                    </asp:Panel>
                </tr>
                <tr>
                    <td>Upload A New Image: 
                    </td>
                    <td>
                        <asp:CheckBox ID="cbNewImage" Checked="false" runat="server" AutoPostBack="true" />
                    </td>
                </tr>
                <asp:Panel ID="pnlNewMovie" runat="server" Visible="false">
                    <tr>
                        <td>Image:
                        </td>
                        <td>
                            <asp:FileUpload ID="fulImage" runat="server"/>
                        </td>
                    </tr>
                </asp:Panel>
            </table>
            <asp:Button ID="btnSave" CssClass="button" runat="server" Text="Save" OnClick="btnSave_Click" />
            <asp:Button ID="btnCancel" CssClass="button" runat="server" Text="Cancel" OnClick="btnCancel_Click" />
        </div>
    </asp:Panel>
</asp:Content>