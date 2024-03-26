using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DAL_Project;
using System.Configuration;
using System.Data;

namespace Movies
{
    public partial class Download : System.Web.UI.Page
    {
        string conn = ConfigurationManager.ConnectionStrings["ConnectTodbMovies"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadMovies();
                LoadDownloads();
            }
        }

        private void LoadDownloads()
        {
            DAL myDal = new DAL(conn);
            lbDownload.DataSource = myDal.ExecuteProcedure("spGetDownloads");
            lbDownload.DataTextField = "Name";
            lbDownload.DataValueField = "Comment";
            lbDownload.DataBind();
        }

        private void LoadMovies()
        {
            DAL myDal = new DAL(conn);
            myDal.AddParam("Column", "NameA");
            ddlMovies.DataSource = myDal.ExecuteProcedure("spGetAllMovies");
            ddlMovies.DataTextField = "Name";
            ddlMovies.DataValueField = "MovieID";
            ddlMovies.DataBind();
        }

        protected void btnRedownload_Click(object sender, EventArgs e)
        {
            if (rfvComment.IsValid)
            {
                DAL myDal = new DAL(conn);
                myDal.AddParam("Name", "** " + ddlMovies.SelectedItem);
                myDal.AddParam("Comment", txtComment.Text);
                myDal.ExecuteProcedure("spAddDownload");

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
                myDal.AddParam("Name", txtDownload.Text);
                myDal.AddParam("Comment", txtComment.Text);
                myDal.ExecuteProcedure("spAddDownload");

                LoadDownloads();
                txtDownload.Text = "";
                txtComment.Text = "";
            }
        }

        protected void btnRemove_Click(object sender, EventArgs e)
        {
            DAL myDal = new DAL(conn);
            myDal.AddParam("Name", lblDownloadName.Text);
            myDal.ExecuteProcedure("spDeleteDownload");

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