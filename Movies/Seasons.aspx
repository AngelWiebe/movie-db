<%@ Page Title="" Language="C#" MasterPageFile="~/TVShows.Master" AutoEventWireup="true" CodeBehind="Seasons.aspx.cs" Inherits="Movies.Seasons" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:HiddenField ID="hfSeasonID" Value="new" runat="server" />
    <table>
        <tr>
            <td>Which Show:
            </td>
            <td>
                <asp:DropDownList ID="ddlShows" runat="server"></asp:DropDownList>
                <asp:Button ID="btnShowSeasons" runat="server" Text="Show Seasons" OnClick="btnShowSeasons_Click" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="btnAddSeason" runat="server" Text="Add Season" OnClick="btnAddSeason_Click" />
            </td>
        </tr>
        <asp:Panel ID="pnlSeason" Visible="false" runat="server">
            <tr>
                <td>Season Number:
                </td>
                <td>
                    <asp:TextBox ID="txtSeasonNumber" runat="server" TextMode="Number"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvSeasonNumber" ControlToValidate="txtSeasonNumber" runat="server" ErrorMessage="Please Enter a Season Number" EnableClientScript="False"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>Year Started:
                </td>
                <td>
                    <asp:TextBox ID="txtYearStarted" runat="server" TextMode="Number"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>Number Of Episodes:
                </td>
                <td>
                    <asp:TextBox ID="txtNumberOfEpisodes" runat="server" TextMode="Number"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvNumberOfEpisodes" ControlToValidate="txtNumberOfEpisodes" runat="server" ErrorMessage="Please Enter Number Of Episodes" EnableClientScript="False"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    Downloaded:
                </td>
                <td>
                    <asp:RadioButton ID="rbNo" Text="No" Checked="true" GroupName="DoIHave" runat="server" />
                    <asp:RadioButton ID="rbYes" Text="Yes" GroupName="DoIHave" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="btnSave" Text="Save" runat="server" OnClick="btnSave_Click" />
                </td>
                <td>
                    <asp:Button ID="btnCancel" Text="Cancel" runat="server" OnClick="btnCancel_Click" />
                </td>
            </tr>
        </asp:Panel>
    </table>
    <br />
    <br />
    <asp:GridView runat="server" ShowFooter="true" AutoGenerateColumns="false" DataKeyNames="SeasonID,ShowID" ID="gvSeasons" Visible="false" OnRowCommand="gvSeasons_RowCommand" OnRowDataBound="gvSeasons_RowDataBound">
        <Columns>
            <asp:BoundField DataField="ShowName" HeaderText="Show Name" />
            <asp:BoundField DataField="SeasonNumber" HeaderText="Season Number" />
            <asp:BoundField DataField="YearStarted" HeaderText="Year Started" />
            <asp:BoundField DataField="NumberOfEpisodes" HeaderText="Number Of Episodes" />
            <asp:CheckBoxField DataField="DoIHave" HeaderText="Downlaoded" />
            <asp:ButtonField ButtonType="Button" CommandName="Del" Text="Delete" />
            <asp:ButtonField ButtonType="Button" CommandName="Upd" Text="Update" />
        </Columns>
    </asp:GridView>
</asp:Content>