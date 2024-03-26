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
    public partial class Default : System.Web.UI.Page
    {
        string conn = ConfigurationManager.ConnectionStrings["ConnectTodbMovies"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadMovies();
                LoadGenres();
                LoadSeries();
            }
            
            if (rbSeriesYes.Checked == true)
                pnlSeries.Visible = true;
            else
                pnlSeries.Visible = false;

            if (cbNewImage.Checked == true)
                pnlNewMovie.Visible = true;
            else
                pnlNewMovie.Visible=false;
        }

        private void LoadSeries()
        {
            DAL myDal = new DAL(conn);
            ddlSeries.DataSource = myDal.ExecuteProcedure("spGetSeries");
            ddlSeries.DataTextField = "SeriesName";
            ddlSeries.DataValueField = "SeriesID";
            ddlSeries.DataBind();
        }

        private void LoadMovies()
        {
            DAL myDal = new DAL(conn);
            myDal.AddParam("column", "NameA");
            ddlMovieList.DataSource = myDal.ExecuteProcedure("spGetAllMovies");
            ddlMovieList.DataTextField = "Name";
            ddlMovieList.DataValueField = "MovieID";
            ddlMovieList.DataBind();
        }

        private void LoadGenres()
        {
            DAL mydal = new DAL(conn);
            ddlGenre.DataSource = mydal.ExecuteProcedure("spGetGenres");
            ddlGenre.DataTextField = "Genre";
            ddlGenre.DataValueField = "GenreID";
            ddlGenre.DataBind();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            pnlContents.Visible = false;
        }

        protected void btnNew_Click(object sender, EventArgs e)
        {
            pnlContents.Visible = true;
            txtMovieName.Text = "";
            txtPlot.Text = "";
            txtYearReleased.Text = "";
            hfMovieID.Value = "new";
            imgMovie.Visible = false;
            cbNewImage.Checked = false;
            rbSeriesNo.Checked = true;
            rbSeriesYes.Checked = false;
            pnlSeries.Visible = false;
            pnlNewMovie.Visible = false;

            LoadGenres();
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            DAL myDal = new DAL(conn);
            myDal.AddParam("MovieID", ddlMovieList.SelectedValue);
            myDal.ExecuteProcedure("spDeleteMovie");

            LoadMovies();
        }

        protected void btnView_Click(object sender, EventArgs e)
        {
            ViewMovie();
        }
        private void ViewMovie()
        {
            pnlContents.Visible = true;
            DAL myDal = new DAL(conn);
            DataSet dsMovies = new DataSet();
            hfMovieID.Value = ddlMovieList.SelectedValue.ToString();
            myDal.AddParam("MovieID", ddlMovieList.SelectedValue);
            dsMovies = myDal.ExecuteProcedure("spGetMovie");
            txtMovieName.Text = ddlMovieList.SelectedItem.Text;
            txtPlot.Text = dsMovies.Tables[0].Rows[0]["Plot"].ToString();
            txtYearReleased.Text = dsMovies.Tables[0].Rows[0]["ReleaseYear"].ToString();
            ddlGenre.SelectedValue = dsMovies.Tables[0].Rows[0]["GenreID"].ToString();
            //ddlGenre.DataBind();

            imgMovie.Visible = true;
            string imageURL = dsMovies.Tables[0].Rows[0]["ImagePath"].ToString();
            imgMovie.ImageUrl = imageURL;

            if(dsMovies.Tables[0].Rows[0]["SeriesID"].ToString() == "NONE")
            {
                rbSeriesYes.Checked = false;
                rbSeriesNo.Checked = true;
                pnlSeries.Visible = false;
            }
            else
            {
                rbSeriesYes.Checked = true;
                rbSeriesNo.Checked = false;
                pnlSeries.Visible = true;
                ddlSeries.SelectedValue = dsMovies.Tables[0].Rows[0]["SeriesID"].ToString();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (rfvMovieName.IsValid)
            {
                DAL myDal = new DAL(conn);
                myDal.AddParam("Name", txtMovieName.Text);
                myDal.AddParam("Genre", ddlGenre.SelectedItem.Text);
                myDal.AddParam("ReleaseYear", txtYearReleased.Text);
                myDal.AddParam("Plot", txtPlot.Text);

                if (rbSeriesNo.Checked == true)
                {
                    ddlSeries.SelectedValue = "NONE";
                    myDal.AddParam("SeriesID", ddlSeries.SelectedValue);
                }
                else
                    myDal.AddParam("SeriesID", ddlSeries.SelectedValue.ToString());

                if (hfMovieID.Value == "new")
                {
                    DataSet dsID = new DataSet();
                    string ID;
                    dsID = myDal.ExecuteProcedure("spAddMovie");
                    ID = dsID.Tables[0].Rows[0]["MovieID"].ToString();
                    hfMovieID.Value = ID;
                    myDal.ClearParams();

                }
                else
                {
                    myDal.AddParam("MovieID", hfMovieID.Value.ToString());
                    myDal.ExecuteProcedure("spUpdateMovie");
                }

                if (cbNewImage.Checked == true)
                {
                    myDal.ClearParams();

                    string serverPath = Server.MapPath(".") + "\\Images\\";
                    string imageName = fulImage.FileName;
                    string imagePath = serverPath + imageName;
                    fulImage.PostedFile.SaveAs(imagePath);
                    myDal.AddParam("ImagePath", imageName);
                    myDal.AddParam("MovieID", hfMovieID.Value.ToString());
                    myDal.ExecuteProcedure("spUpdateImage");
                }
                pnlContents.Visible = false;
                cbNewImage.Checked = false;
                LoadMovies();
            }
        }
    }
}