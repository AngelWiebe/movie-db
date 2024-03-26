<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Series.aspx.cs" Inherits="Movies.Series" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 93px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <table>
        <tr>
            <td>
                <asp:DropDownList ID="ddlSeries" runat="server" AutoPostBack="true" Height="24px" Width="204px"></asp:DropDownList>
            </td>
            <td class="auto-style1"></td>
            <td>
                <asp:Button ID="btnDeleteSeries" runat="server" Text="Delete Series" OnClick="btnDeleteSeries_Click" />
            </td>
        </tr>
    </table>
    <br />
    <asp:Button ID="btnNewSeries" CssClass="button" runat="server" Text="Add A New Series" OnClick="btnNewSeries_Click" />
    <asp:Panel ID="pnlseries" runat="server" Visible="false">
        Series ID:
        <asp:TextBox ID="txtNewSeriesID" runat="server" Width="246px"></asp:TextBox>
        Series Name:
        <asp:TextBox ID="txtNewSeriesName" runat="server" Width="245px"></asp:TextBox>
        <br />
        <asp:Button ID="btnSaveNewSeries" CssClass="button" runat="server" Text="Save" OnClick="btnSaveNewSeries_Click" />
        <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click" />
    </asp:Panel>
    <br />
    <br />
    <asp:GridView ID="gvSeriesMovies" Width="90%" AutoGenerateColumns="false" runat="server">
        <Columns>
            <asp:BoundField DataField="Name" HeaderText="Name" />
            <asp:BoundField DataField="Genre" HeaderText="Genre" />
            <asp:BoundField DataField="ReleaseYear" HeaderText="Year Realeased" />
            <asp:BoundField DataField="Plot" HeaderText="Plot" ControlStyle-Width="90%" />
            <asp:BoundField DataField="SeriesID" HeaderText="Series" />
        </Columns>
    </asp:GridView>
    <br />
</asp:Content>