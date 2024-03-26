<%@ Page Title="" Language="C#" MasterPageFile="~/TVShows.Master" AutoEventWireup="true" CodeBehind="TVShows.aspx.cs" Inherits="Movies.TVShows1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
    .auto-style1 {
        width: 110px;
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="pnlViews" CssClass="Top" runat="server">
        <asp:Image ID="imgDL" ImageUrl="~/Images/four-squares-icon.jpg" runat="server" Height="30px" Width="30px" />
        <asp:RadioButton ID="rbDataList" runat="server" GroupName="WhichView" AutoPostBack="true" Checked="true" />
        <asp:Image ID="imgGrid" ImageUrl="~/Images/images.jpg" runat="server" Height="30px" Width="30px" />
        <asp:RadioButton ID="rbGridView" runat="server" GroupName="WhichView" AutoPostBack="true" />
    </asp:Panel>
    <br />
    <asp:DropDownList ID="ddlShows" runat="server" Height="31px" Width="190px"></asp:DropDownList>
    <asp:Button ID="btnShow" CssClass="button" runat="server" Text="Show Seasons" OnClick="btnShow_Click" />
    <asp:Button ID="btnHideSeasons" runat="server" Text="Hide Seasons" OnClick="btnHideSeasons_Click" />
    <br />
    <br />
    <table>
        <tr>
            <td>Search by Name:
            </td>
            <td class="auto-style1"></td>
            <td>
                <asp:Button ID="btnWhatToWatch" runat="server" Text="Which One Should I Watch?" OnClick="btnWhatToWatch_Click" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txtSearch" runat="server" Width="163px" />
                <asp:Button ID="btnSearch" CssClass="button" runat="server" Text="Search" OnClick="btnSearch_Click"/>
            </td>
            <td class="auto-style1"></td>
            <td>
                <asp:Button ID="btnHide" runat="server" CssClass="button" Text="Hide" OnClick="btnHide_Click" />
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <asp:Button ID="btnOngoing" runat="server" Text="Show All On-Going Shows" OnClick="btnOngoing_Click" />
            </td>
            <td></td>
        </tr>
    </table>
    <br />
    <br />
    <asp:Button ID="btnShowAll" runat="server" CssClass="button" Text="Show All" OnClick="btnShowAll_Click" />
    <br />
    <asp:Label ID="lblCount" runat="server" />
    <br />
    <br />
    <asp:Panel ID="pnlWatch" CssClass="RightLabel" runat="server" Visible="false">
        <table>
            <tr>
                <td>
                    <asp:Image ID="imgWatch" runat="server" Height="236px" CssClass="Left" ImageUrl='<%#Eval("ImageCover")%>' Width="166px" BorderStyle="Inset" BorderColor="#FF0066" BorderWidth="10px" />
                </td>
                <td class="auto-style7"></td>
                <td>
                    <asp:Label ID="lblWatch" runat="server" Font-Bold="true" Font-Size="X-Large"></asp:Label>
                </td>
            </tr>
        </table>
        <br />
        <br />
    </asp:Panel>
    <asp:GridView ID="gvshows" Width="93%" runat="server" DataKeyNames="ImageCover,ShowID" AutoGenerateColumns="false">
        <Columns>
            <asp:BoundField DataField="ShowName" HeaderText="Name"/>
            <asp:BoundField DataField="NumberOfSeasons" HeaderText="Number Of Seasons" />
            <asp:BoundField DataField="Plot" HeaderText="Plot" />
            <asp:BoundField DataField="Concluded" HeaderText="Concluded" />
        </Columns>
    </asp:GridView>
    <asp:GridView ID="gvSeasons" runat="server" Visible="False" AutoGenerateColumns="False" DataKeyNames="SeasonID">
        <Columns>
            <asp:BoundField DataField="SeasonNumber" HeaderText="Season Number" />
            <asp:BoundField DataField="NumberOfEpisodes" HeaderText="Number Of Episodes" />
            <asp:BoundField DataField="YearStarted" HeaderText="YearS tarted" />
            <asp:CheckBoxField DataField="DoIHave" HeaderText="Downloaded" />
        </Columns>
    </asp:GridView>
        <asp:DataList ID="dlShows" ItemStyle-VerticalAlign="Top" Width="95%" runat="server" RepeatColumns="5" DataKeyField="ShowID" HorizontalAlign="Justify" RepeatDirection="Horizontal">
            <ItemTemplate>
                <asp:Image ID="imgMovie" Height="300px" Width="240px" ImageUrl='<%#Eval("ImageCover")%>' runat="server" />
                <br />
                <u><b><asp:Label ID="lblName" runat="server" Text='<%#Eval("ShowName")%>' /></b></u>
                <br />
                <%#Eval("NumberOfSeasons")%>
                <br />
                <%#Eval("Plot")%>
                <br />
                <%#Eval("Concluded")%>
            </ItemTemplate>
        </asp:DataList>
</asp:Content>