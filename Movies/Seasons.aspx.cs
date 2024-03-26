using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DAL_Project;
using System.Configuration;

namespace Movies
{
    public partial class Seasons : System.Web.UI.Page
    {
        int episodeCount = 0;
        string conn = ConfigurationManager.ConnectionStrings["ConnectTodbTVShows"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadShows();
        }

        private void LoadShows()
        {
            DAL myDal = new DAL(conn);
            ddlShows.DataSource = myDal.ExecuteProcedure("spGetShows");
            ddlShows.DataTextField = "ShowName";
            ddlShows.DataValueField = "ShowID";
            ddlShows.DataBind();
        }

        protected void btnAddSeason_Click(object sender, EventArgs e)
        {
            pnlSeason.Visible = true;
            hfSeasonID.Value = "new";
            txtNumberOfEpisodes.Text = "";
            txtSeasonNumber.Text = "";
            txtYearStarted.Text = "";
        }

        protected void btnShowSeasons_Click(object sender, EventArgs e)
        {
            gvSeasons.Visible = true;
            LoadSeasons();
        }
        private void LoadSeasons()
        {
            DAL myDal = new DAL(conn);            
            myDal.AddParam("ShowID", ddlShows.SelectedValue);
            gvSeasons.DataSource = myDal.ExecuteProcedure("spGetSeasons");
            gvSeasons.DataBind();
        }

        protected void gvSeasons_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int rowID = Convert.ToInt32(e.CommandArgument);
            gvSeasons.SelectedIndex = rowID;
            string cmd = e.CommandName;
            string SeasonID = gvSeasons.SelectedDataKey.Value.ToString();

            bool DoIHave = false;
            CheckBox cbDoIHave = (CheckBox)gvSeasons.SelectedRow.FindControl("DoIHave");
            if (cbDoIHave.Checked)
                DoIHave = true;
            else if (!cbDoIHave.Checked)
                DoIHave = false;

            if (gvSeasons.SelectedRow.Cells[4].Text=="true")

            switch (cmd)
            {
                case "Del":
                    DeleteSeason(SeasonID);
                    break;
                case "Upd":
                    UpdateSeason(SeasonID, gvSeasons.SelectedDataKey["ShowID"].ToString(), gvSeasons.SelectedRow.Cells[3].Text, gvSeasons.SelectedRow.Cells[1].Text, gvSeasons.SelectedRow.Cells[2].Text, DoIHave);
                    break;
            }
        }

        private void UpdateSeason(string SeasonID, string ShowID, string NumberOfEpisodes, string SeasonNumber, string YearStarted, bool DoIHave)
        {
            pnlSeason.Visible = true;
            hfSeasonID.Value = SeasonID;
            ddlShows.SelectedValue = ShowID;
            txtNumberOfEpisodes.Text = NumberOfEpisodes;
            txtSeasonNumber.Text = SeasonNumber;
            txtYearStarted.Text = YearStarted;

            if (DoIHave == false)
                rbNo.Checked = true;
            else if (DoIHave == true)
                rbYes.Checked = true;
        }

        private void DeleteSeason(string SeasonID)
        {
            DAL myDal = new DAL(conn);
            myDal.AddParam("SeasonID", SeasonID);
            myDal.ExecuteProcedure("spDeleteSeason");
            LoadSeasons();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            DAL myDal = new DAL(conn);
            bool DoIHave = false;

            if (rbYes.Checked == true)
                DoIHave = true;
            else if (rbNo.Checked == true)
                DoIHave = false;

            myDal.AddParam("ShowID", ddlShows.SelectedValue);
            myDal.AddParam("SeasonNumber", txtSeasonNumber.Text);
            myDal.AddParam("NumberOfEpisodes", txtNumberOfEpisodes.Text);
            myDal.AddParam("YearStarted", txtYearStarted.Text);
            myDal.AddParam("DoIHave", DoIHave.ToString());

            if (hfSeasonID.Value == "new")
                myDal.ExecuteProcedure("spAddSeason");
            else
            {
                myDal.AddParam("SeasonID", hfSeasonID.Value);
                myDal.ExecuteProcedure("spUpdateSeason");
            }
            LoadSeasons();
            pnlSeason.Visible = false;
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            pnlSeason.Visible = false;
        }

        protected void gvSeasons_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            switch(e.Row.RowType)
            {
                case DataControlRowType.Header:
                    episodeCount = 0;
                    break;
                case DataControlRowType.DataRow:
                    int extended = Convert.ToInt32(e.Row.Cells[3].Text);
                    episodeCount = episodeCount + extended;
                    break;
                case DataControlRowType.Footer:
                    e.Row.Cells[3].Text = "Total Episodes: " + episodeCount;
                    break;
            }
        }
    }
}