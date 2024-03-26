<%@ Page Title="" Language="C#" MasterPageFile="~/TVShows.Master" AutoEventWireup="true" CodeBehind="TvDownloads.aspx.cs" Inherits="Movies.TvDownloads" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <style type="text/css">
        .auto-style2 {
            width: 177px;
        }
        .auto-style3 {
            width: 208px;
        }
        .auto-style4 {
            width: 204px;
        }
        .auto-style5 {
            width: 203px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <br />
    <br />
    <table>
        <tr>
            <td class="auto-style4">
                <asp:DropDownList ID="ddlShows" runat="server" Height="44px" Width="163px"></asp:DropDownList>
            </td>
            <td class="auto-style3"></td>
            <td class="auto-style2">
                <asp:Button ID="btnRedownload" runat="server" Text="Re-Download" OnClick="btnRedownload_Click" />
            </td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td>Comment/Season #: 
                <asp:TextBox ID="txtComment" runat="server" TextMode="MultiLine" Width="158px" />
                <asp:RequiredFieldValidator ID="rfvComment" EnableClientScript="false" ControlToValidate="txtComment" runat="server" ErrorMessage="Required Field"></asp:RequiredFieldValidator>
            </td>
            <td></td>
            <td>
                <asp:ListBox ID="lbDownload" runat="server" Height="99px" Width="191px"></asp:ListBox>
            </td>
            <td>
                <asp:Button ID="btnView" runat="server" Text="View" OnClick="btnView_Click" />
            </td>
        </tr>
        <tr>
            <td class="auto-style4">
                <asp:TextBox ID="txtDownload" runat="server" Width="140px" />
            </td>
            <td class="auto-style3"></td>
            <td class="auto-style2">
                <asp:Button ID="btnDownlaod" runat="server" Text="Download" Width="148px" OnClick="btnDownlaod_Click" />
            </td>
            <td class="auto-style5"></td>
        </tr>
    </table>
    <br />
    <br />
    <asp:Panel ID="pnlDownload" runat="server" Visible="false">
        Name:
        <asp:Label ID="lblDownloadName" runat="server" /><br />
        Comment:
        <asp:Label ID="lblDownloadComment" runat="server" /><br />
        <br />
        <asp:Button Text="Remove" ID="btnRemove" runat="server" OnClick="btnRemove_Click" />
        <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click" />
    </asp:Panel>
</asp:Content>