<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="List.aspx.cs" Inherits="Movies.List" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style2 {
            width: 282px;
        }
        .auto-style4 {
            width: 236px;
        }
        .auto-style5 {
            width: 223px;
        }
        .auto-style6 {
            width: 173px;
        }
        .auto-style7 {
            width: 55px;
        }
        .auto-style8 {
            width: 69px;
        }
        .auto-style9 {
            width: 100px;
        }
        .auto-style10 {
            width: 99px;
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
    <table>
        <tr>
            <td class="auto-style4">
                    <asp:DropDownList ID="ddlGenres" runat="server" Height="29px" Width="167px"></asp:DropDownList>
            </td>
            <td class="auto-style5">
                <asp:Button ID="btnDeleteGenre" CssClass="button" runat="server" Text="Delete Genre" OnClick="btnDeleteGenre_Click" />
            </td>
            <td class="auto-style6">
                <asp:Button ID="btnAddGenre" CssClass="button" runat="server" Text="Add New Genre" OnClick="btnAddGenre_Click" />
            </td>
        </tr>
                <tr>
            <td class="auto-style4">
                <asp:Button ID="btnShow" CssClass="button" runat="server" Text="Show by Genre" OnClick="btnShow_Click" />
            </td>
            <td class="auto-style5"></td>
            <td class="auto-style6">
                <asp:TextBox ID="txtNewGenre" runat="server" Visible="false" Width="183px" />
    <asp:Button ID="btnSaveGenre" CssClass="button" runat="server" Text="Save" Visible="false" OnClick="btnSaveGenre_Click" />
            </td>
        </tr>
    </table>
    <br />
    <br />
    <table>
        <tr>
            <td class="auto-style2">Search by Name:
            </td>
            <td class="auto-style8"></td>
            <td>Search By Description:</td>
             <td class="auto-style9"></td>
            <td>Search by Year:
            </td>
            <td class="auto-style10"></td>
            <td>
                 <asp:Button ID="btnWhatToWatch" runat="server" Text="Which One Should I Watch?" OnClick="btnWhatToWatch_Click" />
            </td>
        </tr>
        <tr>
            <td class="auto-style2">
                <asp:TextBox ID="txtSearch" runat="server" Width="163px" />
                <asp:Button ID="btnSearch" CssClass="button" runat="server" Text="Search Name" OnClick="btnSearch_Click" />
            </td>
            <td class="auto-style8"></td>
            <td>
                <asp:TextBox ID="txtSearchDescription" runat="server"></asp:TextBox>
                <asp:Button ID="btnSearchByDescription" runat="server" Text="Search Description" OnClick="btnSearchByDescription_Click" />
                </td>
            <td class="auto-style9"></td>
            <td>
                <asp:DropDownList ID="ddlYear" runat="server" Height="17px" Width="110px" /><br />
                <asp:Button ID="btnSearchByYear" CssClass="button" runat="server" Text="Search by Year" OnClick="btnSearchByYear_Click" />
            </td>
            <td class="auto-style10"></td>
            <td>
                <asp:Button ID="btnHide" runat="server" CssClass="button" Text="Hide" OnClick="btnHide_Click" />
            </td>
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
                    <asp:Image ID="imgWatch" runat="server" Height="236px" CssClass="Left" ImageUrl='<%#Eval("ImagePath")%>' Width="166px" BorderStyle="Inset" BorderColor="#3333CC" BorderWidth="10px" />
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
    <br />
    <br />
    <asp:GridView ID="gvMovies" Width="93%" PageSize="50" runat="server" DataKeyNames="ImagePath" AllowSorting="true" AllowPaging="true" AutoGenerateColumns="false" OnSorting="gvMovies_Sorting" OnPageIndexChanging="gvMovies_PageIndexChanging">
        <Columns>
            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
            <asp:BoundField DataField="Genre" HeaderText="Genre" />
            <asp:BoundField DataField="ReleaseYear" HeaderText="Year Realeased" SortExpression="ReleaseYear" />
            <asp:BoundField DataField="Plot" HeaderText="Plot" />
            <asp:BoundField DataField="SeriesID" HeaderText="Series" SortExpression="SeriesID" />
        </Columns>
    </asp:GridView>
    <asp:GridView ID="gvGenreShow" Width="93%" PageSize="50" runat="server" AllowSorting="true" DataKeyNames="ImagePath" AllowPaging="true" AutoGenerateColumns="false" OnPageIndexChanging="gvGenreShow_PageIndexChanging" OnSorting="gvGenreShow_Sorting">
        <Columns>
            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
            <asp:BoundField DataField="Genre" HeaderText="Genre" />
            <asp:BoundField DataField="ReleaseYear" HeaderText="Year Realeased" SortExpression="ReleaseYear" />
            <asp:BoundField DataField="Plot" HeaderText="Plot" />
            <asp:BoundField DataField="SeriesID" HeaderText="Series" SortExpression="SeriesID" />
        </Columns>
    </asp:GridView>
    <asp:Panel ID="pnlDataList" runat="server" Visible="false">
        <asp:Label ID="lblPage" runat="server" Text="Page:" />
        <asp:DropDownList ID="ddlPageNumber" runat="server"></asp:DropDownList>
       <asp:Button ID="btnSwitchPage" runat="server" Text="Switch Page" OnClick="btnSwitchPage_Click" />
         <br />
    <asp:DataList ID="dlMovies" ItemStyle-VerticalAlign="Top" Width="95%" runat="server" RepeatColumns="5" DataKeyField="MovieID" HorizontalAlign="Justify" RepeatDirection="Horizontal">
        <ItemTemplate>
            <asp:Image ID="imgMovie" Height="300px" Width="240px" ImageUrl='<%#Eval("ImagePath")%>' runat="server" />
            <br />
            <u><b><asp:Label ID="lblName" runat="server" Text='<%#Eval("Name")%>' /></b></u>
            <br />
            <%#Eval("Genre")%>
            <br />
            <%#Eval("ReleaseYear")%>
            <br />
            <%#Eval("Plot")%>
            <br />
            <%#Eval("SeriesID")%>
        </ItemTemplate>
    </asp:DataList>
        </asp:Panel>
</asp:Content>
