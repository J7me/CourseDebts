using MaterialSkin;
using MaterialSkin.Controls;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace Kontra
{
    public partial class MainDebts : MaterialForm
    {
        private DB db = new DB();

        public MainDebts()
        {
            InitializeComponent();

            var materialSkinManager = MaterialSkinManager.Instance;
            materialSkinManager.AddFormToManage(this);
            materialSkinManager.Theme = MaterialSkinManager.Themes.LIGHT;
            materialSkinManager.ColorScheme = new ColorScheme(Primary.Cyan800, Primary.Cyan900, Primary.Cyan500, Accent.Cyan700, TextShade.WHITE);

            LoadData();
            InitializeComboBox();
            InitializeDatePicker();
            InitializeDataGridView();
        }
        private void InitializeComboBox()
        {
            comboBoxStatus.Items.Clear();
            comboBoxStatus.Items.Add("Все статусы");
            comboBoxStatus.Items.Add("HE3ABEPWEHO");
            comboBoxStatus.Items.Add("3ABEPWEHO");
            comboBoxStatus.SelectedIndex = 0;
            comboBoxStatus.SelectedIndexChanged += ComboBoxStatus_SelectedIndexChanged;
        }
        private void InitializeDatePicker()
        {
            DateTime.ValueChanged += DateTimePicker_ValueChanged;
        }
        private void InitializeDataGridView()
        {
            dataGridView.Columns.Clear();
            var idColumn = new DataGridViewTextBoxColumn
            {
                HeaderText = "Id",
                DataPropertyName = "Id", 
                Name = "IdColumn",
                Visible = false 
            };
            dataGridView.Columns.Add(idColumn);
            var subjectColumn = new DataGridViewComboBoxColumn
            {
                HeaderText = "Предмет",
                DataPropertyName = "Subject", 
                Name = "SubjectColumn"
            };
            LoadComboBoxItems("SELECT DISTINCT Subject FROM SubjectDebts", subjectColumn);
            dataGridView.Columns.Add(subjectColumn);
            var statusColumn = new DataGridViewComboBoxColumn
            {
                HeaderText = "Статус",
                DataPropertyName = "Status",
                Name = "StatusColumn"
            };
            statusColumn.Items.AddRange("HE3ABEPWEHO", "3ABEPWEHO");

            dataGridView.Columns.Add(statusColumn);
            dataGridView.AutoGenerateColumns = false;
            dataGridView.Columns.Add(new DataGridViewTextBoxColumn
            {
                HeaderText = "ИмяСтудента",
                DataPropertyName = "StudentName",
                Name = "StudentNameColumn"
            });
            dataGridView.Columns.Add(new DataGridViewTextBoxColumn
            {
                HeaderText = "Описание",
                DataPropertyName = "Description",
                Name = "DescriptionColumn"
            });
            dataGridView.Columns.Add(new DataGridViewTextBoxColumn
            {
                HeaderText = "ДатаВыполнения",
                DataPropertyName = "DueDate",
                Name = "DueDateColumn"
            });

            dataGridView.AllowUserToAddRows = false;
            dataGridView.AllowUserToDeleteRows = true;
            dataGridView.EditMode = DataGridViewEditMode.EditOnEnter;
            dataGridView.DataError += dataGridView_DataError;
        }
        private void dataGridView_DataError(object sender, DataGridViewDataErrorEventArgs e)
        {
            e.ThrowException = false; 
        }
        private void LoadComboBoxItems(string query, DataGridViewComboBoxColumn comboBoxColumn)
        {
            db.openConnection();
            try
            {
                SqlCommand cmd = new SqlCommand(query, db.GetSqlConnection());
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    comboBoxColumn.Items.Add(reader[0].ToString());
                }
            }
            finally
            {
                db.closeConnection();
            }
        }
        private void ComboBoxStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedStatus = comboBoxStatus.SelectedItem.ToString();
            if (selectedStatus == "Все")
            {
                LoadData(); 
            }
            else
            {
                LoadData(filterByStatus: selectedStatus);
            }
        }
        private void DateTimePicker_ValueChanged(object sender, EventArgs e)
        {
            DateTime selectedDate = DateTime.Value.Date;
            LoadData(filterByDate: selectedDate);
        }
        private void LoadData(string filterByStatus = null, string filterBySubject = null, DateTime? filterByDate = null)
        {
            db.openConnection();
            try
            {
                string query = "SELECT Id, StudentName, Subject, Description, DueDate, Status FROM SubjectDebts";
                List<string> filters = new List<string>();
                if (!string.IsNullOrEmpty(filterByStatus))
                {
                    filters.Add($"Status = '{filterByStatus}'");
                }
                if (!string.IsNullOrEmpty(filterBySubject))
                {
                    filters.Add($"Subject = '{filterBySubject}'");
                }
                if (filterByDate.HasValue)
                {
                    filters.Add($"CAST(DueDate AS DATE) = '{filterByDate.Value:yyyy-MM-dd}'");
                }
                if (filters.Count > 0)
                {
                    query += " WHERE " + string.Join(" AND ", filters);
                }

                SqlDataAdapter adapter = new SqlDataAdapter(query, db.GetSqlConnection());
                DataTable table = new DataTable();
                adapter.Fill(table);
                dataGridView.DataSource = table;
                CheckOverdueTasks();
            }
            finally
            {
                db.closeConnection();
            }
        }
        private void CheckOverdueTasks()
        {
            foreach (DataGridViewRow row in dataGridView.Rows)
            {
                if (dataGridView.Columns.Contains("DueDate") &&
                    row.Cells["DueDate"].Value != null &&
                    row.Cells["Status"].Value != null)
                {
                    DateTime dueDate = Convert.ToDateTime(row.Cells["DueDate"].Value);
                    string status = row.Cells["Status"].Value.ToString();
                    if (dueDate < DateTime.Value.Date && status == "HE3ABEPWEHO")
                    {
                        MessageBox.Show($"Просроченная задолженность: {row.Cells["StudentName"].Value} - {row.Cells["Subject"].Value}",
                            "Уведомление", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    }
                }
            }
        }
        private void AddRecord()
        {
            db.openConnection();
            try
            {
                string query = "INSERT INTO SubjectDebts (StudentName, Subject, Description, DueDate, Status) VALUES (@StudentName, @Subject, @Description, @DueDate, @Status)";
                SqlCommand cmd = new SqlCommand(query, db.GetSqlConnection());
                cmd.Parameters.AddWithValue("@StudentName", txtStudentName.Text);
                cmd.Parameters.AddWithValue("@Subject", txtSubject.Text);
                cmd.Parameters.AddWithValue("@Description", txtDescription.Text);
                cmd.Parameters.AddWithValue("@DueDate", DateTime.Value);
                cmd.Parameters.AddWithValue("@Status", comboBoxStatus.Text);
                cmd.ExecuteNonQuery();
            }
            finally
            {
                db.closeConnection();
            }
            LoadData();
        }

        private void DeleteRecord()
        {
            if (dataGridView.SelectedRows.Count > 0)
            {
                var selectedValue = dataGridView.SelectedRows[0].Cells["IdColumn"].Value;

                if (selectedValue != null && int.TryParse(selectedValue.ToString(), out int id))
                {
                    db.openConnection();
                    try
                    {
                        string query = "DELETE FROM SubjectDebts WHERE Id = @Id";
                        SqlCommand cmd = new SqlCommand(query, db.GetSqlConnection());
                        cmd.Parameters.AddWithValue("@Id", id);
                        cmd.ExecuteNonQuery();
                    }
                    finally
                    {
                        db.closeConnection();
                    }
                    LoadData();
                }
                else
                {
                    MessageBox.Show("Выберите строку с корректным идентификатором!", "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
            else
            {
                MessageBox.Show("Выберите строку для удаления!", "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }



        private void EditRecord()
        {
            if (dataGridView.SelectedRows.Count > 0)
            {
                int id = Convert.ToInt32(dataGridView.SelectedRows[0].Cells[0].Value);
                db.openConnection();
                try
                {
                    string query = "UPDATE SubjectDebts SET StudentName = @StudentName, Subject = @Subject, Description = @Description, DueDate = @DueDate, Status = @Status WHERE Id = @Id";
                    SqlCommand cmd = new SqlCommand(query, db.GetSqlConnection());
                    cmd.Parameters.AddWithValue("@StudentName", txtStudentName.Text);
                    cmd.Parameters.AddWithValue("@Subject", txtSubject.Text);
                    cmd.Parameters.AddWithValue("@Description", txtDescription.Text);
                    cmd.Parameters.AddWithValue("@DueDate", DateTime.Value);
                    cmd.Parameters.AddWithValue("@Status", comboBoxStatus.Text);
                    cmd.Parameters.AddWithValue("@Id", id);
                    cmd.ExecuteNonQuery();
                }
                finally
                {
                    db.closeConnection();
                }
                LoadData();
            }
        }

        private void btnAdd_Click(object sender, EventArgs e) => AddRecord();

        private void btnDelete_Click(object sender, EventArgs e) => DeleteRecord();

        private void btnEdit_Click(object sender, EventArgs e) => EditRecord();


    }
}
