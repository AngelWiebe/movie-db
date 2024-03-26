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
    public partial class Series : System.Web.UI.Page
    {
        string conn = ConfigurationManager.ConnectionStrings["ConnectTodbMovies"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadSeries();

            DAL myDal = new DAL(conn);
            myDal.AddParam("SeriesID", ddlSeries.SelectedValue);
            gvSeriesMovies.DataSource = myDal.ExecuteProcedure("spGetMoviesBySeries");
            gvSeriesMovies.DataBind();

        }
        private void LoadSeries()
        {
            DAL myDal = new DAL(conn);
            ddlSeries.DataSource = myDal.ExecuteProcedure("spGetSeries");
            ddlSeries.DataTextField = "SeriesName";
            ddlSeries.DataValueField = "SeriesID";
            ddlSeries.DataBind();
        }

        protected void btnNewSeries_Click(object sender, EventArgs e)
        {
            pnlseries.Visible = true;
            txtNewSeriesID.Text = "";
            txtNewSeriesName.Text = "";
        }

        protected void btnSaveNewSeries_Click(object sender, EventArgs e)
        {
            DAL myDal = new DAL(conn);
            myDal.AddParam("SeriesID", txtNewSeriesID.Text);
            myDal.AddParam("SeriesName", txtNewSeriesName.Text);
            myDal.ExecuteProcedure("spAddSeries");

            LoadSeries();
            pnlseries.Visible = false;
        }

        protected void btnDeleteSeries_Click(object sender, EventArgs e)
        {
            DAL myDal = new DAL(conn);
            myDal.AddParam("SeriesID", ddlSeries.SelectedValue);
            myDal.ExecuteProcedure("spDeleteSeries");
            LoadSeries();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            pnlseries.Visible = false;
        }
    }
}