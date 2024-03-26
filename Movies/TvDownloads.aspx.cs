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
    public partial class TvDownloads : System.Web.UI.Page
    {
        string conn = ConfigurationManager.ConnectionStrings["ConnectTodbTVShows"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadShows();
                LoadDownloads();
            }
        }

        private void LoadDownloads()
        {
            DAL myDal = new DAL(conn);
            lbDownload.DataSource = myDal.ExecuteProcedure("spGetDownloads");
            lbDownload.DataTextField = "ShowName";
            lbDownload.DataValueField = "Comment";
            lbDownload.DataBind();
        }

        private void LoadShows()
        {
            DAL myDal = new DAL(conn);
            ddlShows.DataSource = myDal.ExecuteProcedure("spGetShows");
            ddlShows.DataTextField = "ShowName";
            ddlShows.DataValueField = "ShowID";
            ddlShows.DataBind();
        }

        protected void btnRedownload_Click(object sender, EventArgs e)
        {
            if (rfvComment.IsValid)
            {
                DAL myDal = new DAL(conn);
                myDal.AddParam("ShowName", "** " + ddlShows.SelectedItem);
                myDal.AddParam("Comment", txtComment.Text);
                myDal.ExecuteProcedure("spAddToDownloads");

                LoadDownloads();
                txtDownload.Text = "";
                txtComment.Text = "";
            }
        }

        protected void btnDownlaod_Click(object sender, EventArgs e)
        {
            if (rfvComment.IsValid)
            {
                DAL myDal = new DAL(conn);
                myDal.AddParam("ShowName", txtDownload.Text);
                myDal.AddParam("Comment", txtComment.Text);
                myDal.ExecuteProcedure("spAddToDownloads");

                LoadDownloads();
                txtDownload.Text = "";
                txtComment.Text = "";
            }
        }

        protected void btnRemove_Click(object sender, EventArgs e)
        {
            DAL myDal = new DAL(conn);
            myDal.AddParam("ShowName", lblDownloadName.Text);
            myDal.AddParam("Comment", lblDownloadComment.Text);
            myDal.ExecuteProcedure("spDeleteFromDownloads");

            LoadDownloads();

            pnlDownload.Visible = false;
            txtDownload.Text = "";
            txtComment.Text = "";
        }

        protected void btnView_Click(object sender, EventArgs e)
        {
            if (lbDownload.SelectedItem != null)
            {
                pnlDownload.Visible = true;
                lblDownloadName.Text = lbDownload.SelectedItem.Text;
                lblDownloadComment.Text = lbDownload.SelectedValue.ToString();
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            pnlDownload.Visible = false;
        }
    }
}