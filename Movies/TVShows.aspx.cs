using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using DAL_Project;

namespace Movies
{
    public partial class TVShows1 : System.Web.UI.Page
    {
        string conn = ConfigurationManager.ConnectionStrings["ConnectTodbTVShows"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                LoadShows();
            }
        }

        private void LoadShows()
        {
            DAL myDal = new DAL(conn);
            ddlShows.DataSource = myDal.ExecuteProcedure("spGetShows");
            ddlShows.DataTextField = "ShowName";
            ddlShows.DataValueField = "ShowID";
            ddlShows.DataBind();
        }

        protected void btnShow_Click(object sender, EventArgs e)
        {
            gvshows.Visible = false;
            dlShows.Visible = true;
            DAL myDal = new DAL(conn);
            gvSeasons.Visible = true;
            myDal.AddParam("ShowID",ddlShows.SelectedValue);
            gvSeasons.DataSource = myDal.ExecuteProcedure("spGetSeasons");
            gvSeasons.DataBind();
            lblCount.Text = "Results Found: " + gvSeasons.Rows.Count;
        }

        protected void btnHide_Click(object sender, EventArgs e)
        {
            pnlWatch.Visible = false;
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            DAL myDal = new DAL(conn);
            myDal.AddParam("Name", txtSearch.Text);
            gvSeasons.Visible = false;

            if (rbDataList.Checked == true)
            {
                dlShows.Visible = true;
                gvshows.Visible = false;
                dlShows.DataSource = myDal.ExecuteProcedure("spFindShows");
                dlShows.DataBind();
                lblCount.Text = "Results Found: " + dlShows.Items.Count.ToString();
            }
            else if (rbGridView.Checked == true)
            {
                dlShows.Visible = false;
                gvshows.Visible = true;
                gvshows.DataSource = myDal.ExecuteProcedure("spFindShows");
                gvshows.DataBind();
                lblCount.Text = "Results Found: " + gvshows.Rows.Count.ToString();
            }
        }

        protected void btnShowAll_Click(object sender, EventArgs e)
        {
            gvSeasons.Visible = false;
            DAL myDal = new DAL(conn);

            if(rbGridView.Checked == true)
            {
                gvshows.Visible = true;
                dlShows.Visible = false;
                gvshows.DataSource = myDal.ExecuteProcedure("spGetShows");
                gvshows.DataBind();
                lblCount.Text = "Results Found: " + gvshows.Rows.Count.ToString();
            }
            else if (rbDataList.Checked == true)
            {
                gvshows.Visible = false;
                dlShows.Visible = true;
                dlShows.DataSource = myDal.ExecuteProcedure("spGetShows");
                dlShows.DataBind();
                lblCount.Text = "Results Found: " + dlShows.Items.Count.ToString();
            }
        }

        protected void btnWhatToWatch_Click(object sender, EventArgs e)
        {
            if (rbDataList.Checked == true)
            {
                if (dlShows.Items.Count != 0)
                {
                    pnlWatch.Visible = true;
                    Random rdn = new Random();
                    int whichID = rdn.Next(0, (dlShows.Items.Count));
                    dlShows.SelectedIndex = whichID;
                    Image img = (Image)dlShows.Items[whichID].FindControl("imgMovie");
                    imgWatch.ImageUrl = img.ImageUrl.ToString();
                    lblWatch.Text = ((Label)dlShows.Items[whichID].FindControl("lblName")).Text;
                }
            }
            else if (rbGridView.Checked == true)
            {
                if (gvshows.Rows.Count != 0)
                {
                    pnlWatch.Visible = true;
                    Random rndm = new Random();
                    int whichID = rndm.Next(0, (gvshows.Rows.Count));
                    gvshows.SelectedIndex = whichID;
                    lblWatch.Text = gvshows.SelectedRow.Cells[0].Text;
                    string img = gvshows.SelectedDataKey["CoverImage"].ToString();
                    imgWatch.ImageUrl = img;
                }
                else if (gvSeasons.Rows.Count != 0)
                {
                    pnlWatch.Visible = true;
                    Random rdn = new Random();
                    int whichID = rdn.Next(0, (gvSeasons.Rows.Count));
                    gvSeasons.SelectedIndex = whichID;
                    lblWatch.Text = gvSeasons.SelectedRow.Cells[0].Text;
                    string img = gvSeasons.SelectedDataKey["CoverImage"].ToString();
                    imgWatch.ImageUrl = img;
                }
            }
        }

        protected void btnOngoing_Click(object sender, EventArgs e)
        {
            DAL myDal = new DAL(conn);
            gvSeasons.Visible = false;

            if(rbDataList.Checked ==true)
            {                
                gvshows.Visible = false;
                dlShows.Visible = true;
                dlShows.DataSource = myDal.ExecuteProcedure("spGetOngoingShows");
                dlShows.DataBind();
                lblCount.Text = "Results Found: " + dlShows.Items.Count.ToString();
            }
            else if (rbGridView.Checked == true)
            {
                gvshows.Visible = true;
                dlShows.Visible = false;
                gvshows.DataSource = myDal.ExecuteProcedure("spGetOngoingShows");
                gvshows.DataBind();
                lblCount.Text = "Results Found: " + gvshows.Rows.Count.ToString();
            }
        }

        protected void btnHideSeasons_Click(object sender, EventArgs e)
        {
            gvSeasons.Visible = false;
        }
    }
}