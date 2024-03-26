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
    public partial class List : System.Web.UI.Page
    {
        int PageNumber = 1;
        string conn = ConfigurationManager.ConnectionStrings["ConnectTodbMovies"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["Search"] = "All";
                LoadGenres();
                Session["Column"] = "SeriesID";
                Session["Direction"] = "A";

                DateTime myDate = DateTime.Now;
                int year = myDate.Year;
                LoadYears(year);
                LoadNumberOfPages();
            }
        }

        private void LoadNumberOfPages()
        {
            DAL myDal = new DAL(conn);
            int NumberOfPages = 1;
            ddlPageNumber.Items.Clear();

            if (Session["Search"].ToString() == "All")
                NumberOfPages = Convert.ToInt32(myDal.ExecuteScalar("spGetNumberOfPages"));

            else if (Session["Search"].ToString() == "Genre")
            {
                myDal.AddParam("Genre", ddlGenres.SelectedItem.ToString());
                NumberOfPages = Convert.ToInt32(myDal.ExecuteScalar("spGetNumberOfPagesForGenre"));
            }

            for (int i = 1; i <= NumberOfPages; i++)
            {
                ddlPageNumber.Items.Add(i.ToString());
            }
        }

        private void LoadYears(int year)
        {
            for (int i = year; i >= 1930; i--)
            {
                ddlYear.Items.Add(i.ToString());
            }
        }

        private void LoadGenres()
        {
            DAL myDal = new DAL(conn);
            ddlGenres.DataSource = myDal.ExecuteProcedure("spGetGenres");
            ddlGenres.DataTextField = "Genre";
            ddlGenres.DataValueField = "GenreID";
            ddlGenres.DataBind();
        }

        protected void gvMovies_Sorting(object sender, GridViewSortEventArgs e)
        {
            string newColumn = "";

            switch (e.SortExpression)
            {
                case "Name":
                    newColumn = "Name";
                    break;
                case "SeriesID":
                    newColumn = "SeriesID";
                    break;
                case "ReleaseYear":
                    newColumn = "ReleaseYear";
                    break;
                default:
                    newColumn = "SeriesID";
                    break;
            }
            if (newColumn == Session["Column"].ToString())
            {
                if (Session["Direction"].ToString() == "A")
                    Session["Direction"] = "D";
                else
                    Session["Direction"] = "A";
            }
            else
            {
                Session["Direction"] = "A";
            }

            Session["Column"] = e.SortExpression;
            DAL myDal = new DAL(conn);
            string column = Session["Column"].ToString() + Session["Direction"].ToString();
            myDal.AddParam("column", column);
            gvMovies.DataSource = myDal.ExecuteProcedure("spGetAllMovies");
            gvMovies.DataBind();

        }

        protected void btnShowAll_Click(object sender, EventArgs e)
        {
            DAL myDal = new DAL(conn);

            if (rbDataList.Checked == true)
            {
                Session["Search"] = "All";
                LoadDataList();
            }
            else if (rbGridView.Checked == true)
            {
                pnlDataList.Visible = false;
                gvMovies.Visible = true;
                gvGenreShow.Visible = false;
                string column = Session["Column"].ToString() + Session["Direction"].ToString();
                myDal.AddParam("column", column);
                gvMovies.DataSource = myDal.ExecuteProcedure("spGetAllMovies");
                gvMovies.DataBind();
                lblCount.Text = "Results Found:" + gvMovies.Rows.Count.ToString();
            }

        }

        protected void btnShow_Click(object sender, EventArgs e)
        {
            DAL myDal = new DAL(conn);
            myDal.AddParam("Genre", ddlGenres.SelectedItem.Text);

            if (rbDataList.Checked == true)
            {
                Session["Search"] = "Genre";
                LoadDataList();
            }
            else if (rbGridView.Checked == true)
            {
                pnlDataList.Visible = false;
                gvMovies.Visible = false;
                gvGenreShow.Visible = true;
                string column = Session["Column"].ToString() + Session["Direction"].ToString();
                myDal.AddParam("column", column);
                gvGenreShow.DataSource = myDal.ExecuteProcedure("spGetMoviesFromGenre");
                gvGenreShow.DataBind();
                lblCount.Text = "Results Found:" + gvGenreShow.Rows.Count.ToString();
            }
        }

        private void LoadDataList()
        {
            btnSwitchPage.Visible = true;
            ddlPageNumber.Visible = true;
            lblPage.Visible = true;
            gvMovies.Visible = false;
            pnlDataList.Visible = true;
            gvGenreShow.Visible = false;
            DAL myDal = new DAL(conn);
            PageNumber = Convert.ToInt32(ddlPageNumber.SelectedValue);
            myDal.AddParam("PageNumber", PageNumber.ToString());

            if (Session["Search"].ToString() == "All")
                dlMovies.DataSource = myDal.ExecuteProcedure("spGetAllMoviesDataList");
            else if (Session["Search"].ToString() == "Genre")
            {
                myDal.AddParam("Genre", ddlGenres.SelectedItem.ToString());
                dlMovies.DataSource = myDal.ExecuteProcedure("spGetMoviesDataListForGenre");
            }

            dlMovies.DataBind();
            LoadNumberOfPages();
            lblCount.Text = "Results Found:" + dlMovies.Items.Count.ToString();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            DAL myDal = new DAL(conn);
            myDal.AddParam("Name", txtSearch.Text);

            if (rbDataList.Checked == true)
            {
                btnSwitchPage.Visible = false;
                ddlPageNumber.Visible = false;
                lblPage.Visible = false;
                gvMovies.Visible = false;
                pnlDataList.Visible = true;
                gvGenreShow.Visible = false;
                dlMovies.DataSource = myDal.ExecuteProcedure("spFindMovies");
                dlMovies.DataBind();
                lblCount.Text = "Results Found:" + dlMovies.Items.Count.ToString();
            }
            else if (rbGridView.Checked == true)
            {
                gvMovies.Visible = true;
                pnlDataList.Visible = false;
                gvGenreShow.Visible = false;
                gvMovies.DataSource = myDal.ExecuteProcedure("spFindMovies");
                gvMovies.DataBind();
                lblCount.Text = "Results Found:" + gvMovies.Rows.Count.ToString();
            }
        }

        protected void btnWhatToWatch_Click(object sender, EventArgs e)
        {
            if (rbDataList.Checked == true)
            {
                if (dlMovies.Items.Count != 0)
                {
                    pnlWatch.Visible = true;
                    Random rdn = new Random();
                    int whichID = rdn.Next(0, (dlMovies.Items.Count));
                    dlMovies.SelectedIndex = whichID;
                    Image img = (Image)dlMovies.Items[whichID].FindControl("imgMovie");
                    imgWatch.ImageUrl = img.ImageUrl.ToString();
                    lblWatch.Text = ((Label)dlMovies.Items[whichID].FindControl("lblName")).Text;
                }
            }
            else if (rbGridView.Checked == true)
            {
                if (gvMovies.Rows.Count != 0)
                {
                    pnlWatch.Visible = true;
                    Random rndm = new Random();
                    int whichID = rndm.Next(0, (gvMovies.Rows.Count));
                    gvMovies.SelectedIndex = whichID;
                    lblWatch.Text = gvMovies.SelectedRow.Cells[0].Text;
                    string img = gvMovies.SelectedDataKey["ImagePath"].ToString();
                    imgWatch.ImageUrl = img;
                }
                else if (gvGenreShow.Rows.Count != 0)
                {
                    pnlWatch.Visible = true;
                    Random rdn = new Random();
                    int whichID = rdn.Next(0, (gvGenreShow.Rows.Count));
                    gvGenreShow.SelectedIndex = whichID;
                    lblWatch.Text = gvGenreShow.SelectedRow.Cells[0].Text;
                    string img = gvMovies.SelectedDataKey["ImagePath"].ToString();
                    imgWatch.ImageUrl = img;
                }
            }
        }

        protected void btnHide_Click(object sender, EventArgs e)
        {
            pnlWatch.Visible = false;
        }

        protected void gvMovies_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvMovies.PageIndex = e.NewPageIndex;
            DAL myDal = new DAL(conn);
            string column = Session["Column"].ToString() + Session["Direction"].ToString();
            myDal.AddParam("column", column);
            gvMovies.DataSource = myDal.ExecuteProcedure("spGetAllMovies");
            gvMovies.DataBind();
            lblCount.Text = "Results Found:" + gvMovies.Rows.Count.ToString();
        }

        protected void gvGenreShow_Sorting(object sender, GridViewSortEventArgs e)
        {
            string newColumn = "";

            switch (e.SortExpression)
            {
                case "Name":
                    newColumn = "Name";
                    break;
                case "SeriesID":
                    newColumn = "SeriesID";
                    break;
                case "ReleaseYear":
                    newColumn = "ReleaseYear";
                    break;
                default:
                    newColumn = "SeriesID";
                    break;
            }
            if (newColumn == Session["Column"].ToString())
            {
                if (Session["Direction"].ToString() == "A")
                    Session["Direction"] = "D";
                else
                    Session["Direction"] = "A";
            }
            else
                Session["Direction"] = "A";

            Session["Column"] = e.SortExpression;
            DAL myDal = new DAL(conn);
            string column = Session["Column"].ToString() + Session["Direction"].ToString();
            myDal.AddParam("Genre", ddlGenres.SelectedItem.Text);
            myDal.AddParam("column", column);
            gvGenreShow.DataSource = myDal.ExecuteProcedure("spGetMoviesFromGenre");
            gvGenreShow.DataBind();
            lblCount.Text = "Results Found:" + gvGenreShow.Rows.Count.ToString();
        }

        protected void gvGenreShow_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvGenreShow.PageIndex = e.NewPageIndex;
            DAL myDal = new DAL(conn);
            string column = Session["Column"].ToString() + Session["Direction"].ToString();
            myDal.AddParam("Genre", ddlGenres.SelectedItem.Text);
            myDal.AddParam("column", column);
            gvGenreShow.DataSource = myDal.ExecuteProcedure("spGetMoviesFromGenre");
            gvGenreShow.DataBind();
            lblCount.Text = "Results Found:" + gvGenreShow.Rows.Count.ToString();
        }

        protected void btnAddGenre_Click(object sender, EventArgs e)
        {
            btnSaveGenre.Visible = true;
            txtNewGenre.Visible = true;
        }
        protected void btnSaveGenre_Click(object sender, EventArgs e)
        {
            DAL myDal = new DAL(conn);
            myDal.AddParam("Genre", txtNewGenre.Text);
            myDal.ExecuteProcedure("spAddGenre");
            LoadGenres();
            txtNewGenre.Visible = false;
            btnSaveGenre.Visible = false;
        }
        protected void btnDeleteGenre_Click(object sender, EventArgs e)
        {
            DAL myDal = new DAL(conn);
            myDal.AddParam("GenreID", ddlGenres.SelectedValue);
            myDal.ExecuteProcedure("spDeleteGenre");
            LoadGenres();
        }
        protected void btnSearchByYear_Click(object sender, EventArgs e)
        {
            DAL myDal = new DAL(conn);
            myDal.AddParam("Year", ddlYear.SelectedValue);
            if (rbDataList.Checked == true)
            {
                btnSwitchPage.Visible = false;
                ddlPageNumber.Visible = false;
                lblPage.Visible = false;
                pnlDataList.Visible = true;
                gvGenreShow.Visible = false;
                gvMovies.Visible = false;
                dlMovies.DataSource = myDal.ExecuteProcedure("spSearchByYear");
                dlMovies.DataBind();
                lblCount.Text = "Results Found:" + dlMovies.Items.Count.ToString();
            }
            else if (rbGridView.Checked == true)
            {
                gvMovies.Visible = true;
                gvGenreShow.Visible = false;
                pnlDataList.Visible = false;
                gvMovies.DataSource = myDal.ExecuteProcedure("spSearchByYear");
                gvMovies.DataBind();
                lblCount.Text = "Results Found:" + gvMovies.Rows.Count.ToString();
            }
        }

        protected void btnSwitchPage_Click(object sender, EventArgs e)
        {
                LoadDataList();
        }

        protected void btnSearchByDescription_Click(object sender, EventArgs e)
        {
            DAL myDal = new DAL(conn);
            myDal.AddParam("Plot", txtSearchDescription.Text);

            if (rbDataList.Checked == true)
            {
                btnSwitchPage.Visible = false;
                ddlPageNumber.Visible = false;
                lblPage.Visible = false;
                gvMovies.Visible = false;
                pnlDataList.Visible = true;
                gvGenreShow.Visible = false;
                dlMovies.DataSource = myDal.ExecuteProcedure("spFindByPlot");
                dlMovies.DataBind();
                lblCount.Text = "Results Found:" + dlMovies.Items.Count.ToString();
            }
            else if (rbGridView.Checked == true)
            {
                gvMovies.Visible = true;
                pnlDataList.Visible = false;
                gvGenreShow.Visible = false;
                gvMovies.DataSource = myDal.ExecuteProcedure("spFindByPlot");
                gvMovies.DataBind();
                lblCount.Text = "Results Found:" + gvMovies.Rows.Count.ToString();
            }
        }
    }
}