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
    public partial class TVCrud : System.Web.UI.Page
    {
        string conn = ConfigurationManager.ConnectionStrings["ConnectTodbTVShows"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadShows();
            if (cbNewImage.Checked == true)
                pnlNewImage.Visible = true;
            else
                pnlNewImage.Visible = false;
        }

        private void LoadShows()
        {
            DAL myDal = new DAL(conn);
            ddlShows.DataSource = myDal.ExecuteProcedure("spGetShows");
            ddlShows.DataTextField = "ShowName";
            ddlShows.DataValueField = "ShowID";
            ddlShows.DataBind();
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            DAL myDal = new DAL(conn);
            myDal.AddParam("ShowID", ddlShows.SelectedValue);
            myDal.ExecuteProcedure("spDeleteShow");

            LoadShows();
        }

        protected void btnView_Click(object sender, EventArgs e)
        {
            string concluded;
            DAL myDal = new DAL(conn);
            DataSet ds = new DataSet();
            pnlContents.Visible = true;
            hfShowID.Value = ddlShows.SelectedValue.ToString();
            myDal.AddParam("ShowID", ddlShows.SelectedValue.ToString());
            ds = myDal.ExecuteProcedure("spGetShows");
            txtShowName.Text = ddlShows.SelectedItem.Text;
            txtPlot.Text = ds.Tables[0].Rows[0]["Plot"].ToString();
            txtNumberOfSeasons.Text = ds.Tables[0].Rows[0]["NumberOfSeasons"].ToString();
            concluded = ds.Tables[0].Rows[0]["Concluded"].ToString();

            if (concluded == "Yes")
            {
                rbYes.Checked = true;
                rbNo.Checked = false;
            }
            else
            {
                rbNo.Checked = true;
                rbYes.Checked = false;
            }
            imgShow.Visible = true;
            string imageURL = ds.Tables[0].Rows[0]["ImageCover"].ToString();
            imgShow.ImageUrl = imageURL;
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            pnlContents.Visible = false;
        }

        protected void btnNew_Click(object sender, EventArgs e)
        {
            imgShow.Visible = false;
            hfShowID.Value = "new";
            txtNumberOfSeasons.Text = "";
            txtPlot.Text = "";
            txtShowName.Text = "";
            pnlContents.Visible = true;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (rfvShowName.IsValid)
            {
                string concluded;
                DAL myDal = new DAL(conn);
                myDal.AddParam("ShowName", txtShowName.Text);
                myDal.AddParam("NumberOfSeasons", txtNumberOfSeasons.Text);
                myDal.AddParam("Plot", txtPlot.Text);

                if (rbNo.Checked == true)
                    concluded = "No";

                else
                    concluded = "Yes";
                myDal.AddParam("Concluded", concluded);

                if (hfShowID.Value == "new")
                {
                    DataSet dsID = new DataSet();
                    string ID;
                    dsID = myDal.ExecuteProcedure("spAddShow");
                    ID = dsID.Tables[0].Rows[0]["ShowID"].ToString();
                    hfShowID.Value = ID;
                    myDal.ClearParams();
                }

                else
                {
                    myDal.AddParam("ShowID", hfShowID.Value.ToString());
                    myDal.ExecuteProcedure("spUpdateShow");
                }

                if (cbNewImage.Checked == true)
                {
                    myDal.ClearParams();

                    string serverPath = Server.MapPath(".") + "\\Images\\";
                    string imageName = fulImage.FileName;
                    string imagePath = serverPath + imageName;
                    fulImage.PostedFile.SaveAs(imagePath);
                    myDal.AddParam("ImageCover", imageName);
                    myDal.AddParam("ShowID", hfShowID.Value.ToString());
                    myDal.ExecuteProcedure("spUpdateShowImage");
                }
                pnlContents.Visible = false;
                cbNewImage.Checked = false;
                LoadShows();
            }
        }
    }
}