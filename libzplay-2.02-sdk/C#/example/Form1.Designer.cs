using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Diagnostics;
using System.Windows.Forms;
using System.Linq;
using System.Xml.Linq;

using libZPlay;

namespace libZPlay_player
{
	/// <summary>
	/// Form1
	/// </summary>
	/// <remarks></remarks>
	[Microsoft.VisualBasic.CompilerServices.DesignerGenerated()]
	public partial class Form1 : System.Windows.Forms.Form
	{

		//Form overrides dispose to clean up the component list.
		/// <summary>
		/// Dispose
		/// </summary>
		/// <param name="disposing"></param>
		/// <remarks></remarks>
		[System.Diagnostics.DebuggerNonUserCode()]
		protected override void Dispose(bool disposing)
		{
			try
			{
				if (disposing && components != null)
				{
					components.Dispose();
				}
			}
			finally
			{
				base.Dispose(disposing);
			}
		}

		//Required by the Windows Form Designer
		private System.ComponentModel.IContainer components;

		//NOTE: The following procedure is required by the Windows Form Designer
		//It can be modified using the Windows Form Designer.  
		//Do not modify it using the code editor.
		[System.Diagnostics.DebuggerStepThrough()]
		private void InitializeComponent()
		{
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form1));
            this.Button1 = new System.Windows.Forms.Button();
            this.OpenFileDialog1 = new System.Windows.Forms.OpenFileDialog();
            this.Button2 = new System.Windows.Forms.Button();
            this.Button3 = new System.Windows.Forms.Button();
            this.Button4 = new System.Windows.Forms.Button();
            this.Button5 = new System.Windows.Forms.Button();
            this.Button6 = new System.Windows.Forms.Button();
            this.Button7 = new System.Windows.Forms.Button();
            this.GroupBox1 = new System.Windows.Forms.GroupBox();
            this.descr1 = new System.Windows.Forms.Label();
            this.descr = new System.Windows.Forms.Label();
            this.Button8 = new System.Windows.Forms.Button();
            this.ProgressBar1 = new System.Windows.Forms.ProgressBar();
            this.Timer1 = new System.Windows.Forms.Timer(this.components);
            this.Button9 = new System.Windows.Forms.Button();
            this.Button10 = new System.Windows.Forms.Button();
            this.Button11 = new System.Windows.Forms.Button();
            this.Button12 = new System.Windows.Forms.Button();
            this.GroupBox2 = new System.Windows.Forms.GroupBox();
            this.position = new System.Windows.Forms.Label();
            this.GroupBox3 = new System.Windows.Forms.GroupBox();
            this.leftplayervolume = new System.Windows.Forms.VScrollBar();
            this.rightplayervolume = new System.Windows.Forms.VScrollBar();
            this.rightmastervolume = new System.Windows.Forms.VScrollBar();
            this.leftmastervolume = new System.Windows.Forms.VScrollBar();
            this.GroupBox5 = new System.Windows.Forms.GroupBox();
            this.statusvalue2 = new System.Windows.Forms.Label();
            this.statuslabel2 = new System.Windows.Forms.Label();
            this.statusvalue1 = new System.Windows.Forms.Label();
            this.statuslabel1 = new System.Windows.Forms.Label();
            this.leftvu = new System.Windows.Forms.ProgressBar();
            this.rightvu = new System.Windows.Forms.ProgressBar();
            this.Timer2 = new System.Windows.Forms.Timer(this.components);
            this.Button13 = new System.Windows.Forms.Button();
            this.Button14 = new System.Windows.Forms.Button();
            this.GroupBox6 = new System.Windows.Forms.GroupBox();
            this.VScrollBar11 = new System.Windows.Forms.VScrollBar();
            this.VScrollBar10 = new System.Windows.Forms.VScrollBar();
            this.VScrollBar9 = new System.Windows.Forms.VScrollBar();
            this.VScrollBar8 = new System.Windows.Forms.VScrollBar();
            this.VScrollBar7 = new System.Windows.Forms.VScrollBar();
            this.VScrollBar6 = new System.Windows.Forms.VScrollBar();
            this.VScrollBar5 = new System.Windows.Forms.VScrollBar();
            this.VScrollBar4 = new System.Windows.Forms.VScrollBar();
            this.VScrollBar3 = new System.Windows.Forms.VScrollBar();
            this.VScrollBar2 = new System.Windows.Forms.VScrollBar();
            this.VScrollBar1 = new System.Windows.Forms.VScrollBar();
            this.CheckBox1 = new System.Windows.Forms.CheckBox();
            this.Button15 = new System.Windows.Forms.Button();
            this.GroupBox7 = new System.Windows.Forms.GroupBox();
            this.VScrollBar14 = new System.Windows.Forms.VScrollBar();
            this.VScrollBar13 = new System.Windows.Forms.VScrollBar();
            this.VScrollBar12 = new System.Windows.Forms.VScrollBar();
            this.Button16 = new System.Windows.Forms.Button();
            this.GroupBox8 = new System.Windows.Forms.GroupBox();
            this.checkBox3 = new System.Windows.Forms.CheckBox();
            this.CheckBox2 = new System.Windows.Forms.CheckBox();
            this.ComboBox3 = new System.Windows.Forms.ComboBox();
            this.ComboBox2 = new System.Windows.Forms.ComboBox();
            this.FFTLinear = new System.Windows.Forms.CheckBox();
            this.ComboBox1 = new System.Windows.Forms.ComboBox();
            this.FFTEnabled = new System.Windows.Forms.CheckBox();
            this.PictureBox1 = new System.Windows.Forms.PictureBox();
            this.Button17 = new System.Windows.Forms.Button();
            this.callback_text = new System.Windows.Forms.Label();
            this.button18 = new System.Windows.Forms.Button();
            this.pictureBox2 = new System.Windows.Forms.PictureBox();
            this.saveFileDialog1 = new System.Windows.Forms.SaveFileDialog();
            this.groupBox4 = new System.Windows.Forms.GroupBox();
            this.groupBox10 = new System.Windows.Forms.GroupBox();
            this.Button20 = new System.Windows.Forms.Button();
            this.CheckBox4 = new System.Windows.Forms.CheckBox();
            this.Label2 = new System.Windows.Forms.Label();
            this.Label1 = new System.Windows.Forms.Label();
            this.ComboBox5 = new System.Windows.Forms.ComboBox();
            this.ComboBox4 = new System.Windows.Forms.ComboBox();
            this.GroupBox9 = new System.Windows.Forms.GroupBox();
            this.Label16 = new System.Windows.Forms.Label();
            this.Label15 = new System.Windows.Forms.Label();
            this.Label14 = new System.Windows.Forms.Label();
            this.Label13 = new System.Windows.Forms.Label();
            this.Label12 = new System.Windows.Forms.Label();
            this.Label11 = new System.Windows.Forms.Label();
            this.Label10 = new System.Windows.Forms.Label();
            this.Label9 = new System.Windows.Forms.Label();
            this.Label8 = new System.Windows.Forms.Label();
            this.Label7 = new System.Windows.Forms.Label();
            this.Label6 = new System.Windows.Forms.Label();
            this.Label5 = new System.Windows.Forms.Label();
            this.Label4 = new System.Windows.Forms.Label();
            this.Label3 = new System.Windows.Forms.Label();
            this.GroupBox1.SuspendLayout();
            this.GroupBox2.SuspendLayout();
            this.GroupBox3.SuspendLayout();
            this.GroupBox5.SuspendLayout();
            this.GroupBox6.SuspendLayout();
            this.GroupBox7.SuspendLayout();
            this.GroupBox8.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.PictureBox1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox2)).BeginInit();
            this.groupBox4.SuspendLayout();
            this.groupBox10.SuspendLayout();
            this.GroupBox9.SuspendLayout();
            this.SuspendLayout();
            // 
            // Button1
            // 
            this.Button1.Location = new System.Drawing.Point(12, 1);
            this.Button1.Name = "Button1";
            this.Button1.Size = new System.Drawing.Size(132, 21);
            this.Button1.TabIndex = 0;
            this.Button1.Text = "Open file";
            this.Button1.UseVisualStyleBackColor = true;
            this.Button1.Click += new System.EventHandler(this.Button1_Click);
            // 
            // OpenFileDialog1
            // 
            this.OpenFileDialog1.Filter = "All Supported Files|*.mp3;*.mp2;*.mp1;*.ogg;*.oga;*.flac;*.wav;*.ac3;*.aac|Mp3 Fi" +
                "les|*.mp3|Mp2 Files|*.mp2|Mp1 Files|*.mp1|Ogg Files|*.ogg|FLAC files|*.flac|Wav " +
                "files|*.wav|AC-3|*.ac3|AAC|*.aac";
            this.OpenFileDialog1.Title = "Open song";
            this.OpenFileDialog1.FileOk += new System.ComponentModel.CancelEventHandler(this.OpenFileDialog1_FileOk);
            // 
            // Button2
            // 
            this.Button2.Location = new System.Drawing.Point(12, 129);
            this.Button2.Name = "Button2";
            this.Button2.Size = new System.Drawing.Size(63, 23);
            this.Button2.TabIndex = 1;
            this.Button2.Text = "Play";
            this.Button2.UseVisualStyleBackColor = true;
            this.Button2.Click += new System.EventHandler(this.Button2_Click);
            // 
            // Button3
            // 
            this.Button3.Location = new System.Drawing.Point(81, 129);
            this.Button3.Name = "Button3";
            this.Button3.Size = new System.Drawing.Size(63, 23);
            this.Button3.TabIndex = 2;
            this.Button3.Text = "Pause";
            this.Button3.UseVisualStyleBackColor = true;
            this.Button3.Click += new System.EventHandler(this.Button3_Click);
            // 
            // Button4
            // 
            this.Button4.Location = new System.Drawing.Point(150, 129);
            this.Button4.Name = "Button4";
            this.Button4.Size = new System.Drawing.Size(64, 23);
            this.Button4.TabIndex = 3;
            this.Button4.Text = "Resume";
            this.Button4.UseVisualStyleBackColor = true;
            this.Button4.Click += new System.EventHandler(this.Button4_Click);
            // 
            // Button5
            // 
            this.Button5.Location = new System.Drawing.Point(220, 129);
            this.Button5.Name = "Button5";
            this.Button5.Size = new System.Drawing.Size(63, 23);
            this.Button5.TabIndex = 4;
            this.Button5.Text = "Stop";
            this.Button5.UseVisualStyleBackColor = true;
            this.Button5.Click += new System.EventHandler(this.Button5_Click);
            // 
            // Button6
            // 
            this.Button6.Location = new System.Drawing.Point(12, 28);
            this.Button6.Name = "Button6";
            this.Button6.Size = new System.Drawing.Size(132, 21);
            this.Button6.TabIndex = 5;
            this.Button6.Text = "Open static stream";
            this.Button6.UseVisualStyleBackColor = true;
            this.Button6.Click += new System.EventHandler(this.Button6_Click);
            // 
            // Button7
            // 
            this.Button7.Location = new System.Drawing.Point(151, 28);
            this.Button7.Name = "Button7";
            this.Button7.Size = new System.Drawing.Size(132, 21);
            this.Button7.TabIndex = 6;
            this.Button7.Text = "Open dynamic stream";
            this.Button7.UseVisualStyleBackColor = true;
            this.Button7.Click += new System.EventHandler(this.Button7_Click);
            // 
            // GroupBox1
            // 
            this.GroupBox1.Controls.Add(this.descr1);
            this.GroupBox1.Controls.Add(this.descr);
            this.GroupBox1.Location = new System.Drawing.Point(290, 1);
            this.GroupBox1.Name = "GroupBox1";
            this.GroupBox1.Size = new System.Drawing.Size(296, 108);
            this.GroupBox1.TabIndex = 7;
            this.GroupBox1.TabStop = false;
            this.GroupBox1.Text = "Info";
            // 
            // descr1
            // 
            this.descr1.Location = new System.Drawing.Point(97, 16);
            this.descr1.Name = "descr1";
            this.descr1.Size = new System.Drawing.Size(193, 83);
            this.descr1.TabIndex = 1;
            // 
            // descr
            // 
            this.descr.Location = new System.Drawing.Point(7, 16);
            this.descr.Name = "descr";
            this.descr.Size = new System.Drawing.Size(84, 83);
            this.descr.TabIndex = 0;
            // 
            // Button8
            // 
            this.Button8.Location = new System.Drawing.Point(150, 181);
            this.Button8.Name = "Button8";
            this.Button8.Size = new System.Drawing.Size(63, 23);
            this.Button8.TabIndex = 8;
            this.Button8.Text = "Vocal cut";
            this.Button8.UseVisualStyleBackColor = true;
            this.Button8.Click += new System.EventHandler(this.Button8_Click);
            // 
            // ProgressBar1
            // 
            this.ProgressBar1.Location = new System.Drawing.Point(12, 266);
            this.ProgressBar1.Name = "ProgressBar1";
            this.ProgressBar1.Size = new System.Drawing.Size(271, 23);
            this.ProgressBar1.Step = 1;
            this.ProgressBar1.Style = System.Windows.Forms.ProgressBarStyle.Continuous;
            this.ProgressBar1.TabIndex = 9;
            this.ProgressBar1.Tag = "Click to seek position";
            this.ProgressBar1.MouseClick += new System.Windows.Forms.MouseEventHandler(this.ProgressBar1_MouseClick);
            // 
            // Timer1
            // 
            this.Timer1.Interval = 200;
            this.Timer1.Tick += new System.EventHandler(this.Timer1_Tick);
            // 
            // Button9
            // 
            this.Button9.Location = new System.Drawing.Point(12, 155);
            this.Button9.Name = "Button9";
            this.Button9.Size = new System.Drawing.Size(63, 23);
            this.Button9.TabIndex = 10;
            this.Button9.Text = "Jump rev";
            this.Button9.UseVisualStyleBackColor = true;
            this.Button9.Click += new System.EventHandler(this.Button9_Click);
            // 
            // Button10
            // 
            this.Button10.Location = new System.Drawing.Point(81, 155);
            this.Button10.Name = "Button10";
            this.Button10.Size = new System.Drawing.Size(63, 23);
            this.Button10.TabIndex = 11;
            this.Button10.Text = "Jump fwd";
            this.Button10.UseVisualStyleBackColor = true;
            this.Button10.Click += new System.EventHandler(this.Button10_Click);
            // 
            // Button11
            // 
            this.Button11.Location = new System.Drawing.Point(150, 155);
            this.Button11.Name = "Button11";
            this.Button11.Size = new System.Drawing.Size(64, 23);
            this.Button11.TabIndex = 12;
            this.Button11.Text = "Loop 2 sec";
            this.Button11.UseVisualStyleBackColor = true;
            this.Button11.Click += new System.EventHandler(this.Button11_Click);
            // 
            // Button12
            // 
            this.Button12.Location = new System.Drawing.Point(152, 208);
            this.Button12.Name = "Button12";
            this.Button12.Size = new System.Drawing.Size(132, 23);
            this.Button12.TabIndex = 13;
            this.Button12.Text = "Reverse mode";
            this.Button12.UseVisualStyleBackColor = true;
            this.Button12.Click += new System.EventHandler(this.Button12_Click);
            // 
            // GroupBox2
            // 
            this.GroupBox2.Controls.Add(this.position);
            this.GroupBox2.Location = new System.Drawing.Point(12, 217);
            this.GroupBox2.Name = "GroupBox2";
            this.GroupBox2.Size = new System.Drawing.Size(106, 43);
            this.GroupBox2.TabIndex = 14;
            this.GroupBox2.TabStop = false;
            this.GroupBox2.Text = "Position";
            // 
            // position
            // 
            this.position.Location = new System.Drawing.Point(6, 16);
            this.position.Name = "position";
            this.position.Size = new System.Drawing.Size(94, 20);
            this.position.TabIndex = 0;
            // 
            // GroupBox3
            // 
            this.GroupBox3.Controls.Add(this.leftplayervolume);
            this.GroupBox3.Controls.Add(this.rightplayervolume);
            this.GroupBox3.Controls.Add(this.rightmastervolume);
            this.GroupBox3.Controls.Add(this.leftmastervolume);
            this.GroupBox3.Location = new System.Drawing.Point(592, 1);
            this.GroupBox3.Name = "GroupBox3";
            this.GroupBox3.Size = new System.Drawing.Size(177, 141);
            this.GroupBox3.TabIndex = 15;
            this.GroupBox3.TabStop = false;
            this.GroupBox3.Text = "Master - Player volume";
            // 
            // leftplayervolume
            // 
            this.leftplayervolume.LargeChange = 1;
            this.leftplayervolume.Location = new System.Drawing.Point(102, 16);
            this.leftplayervolume.Name = "leftplayervolume";
            this.leftplayervolume.Size = new System.Drawing.Size(20, 115);
            this.leftplayervolume.TabIndex = 0;
            this.leftplayervolume.ValueChanged += new System.EventHandler(this.leftplayervolume_ValueChanged);
            this.leftplayervolume.Scroll += new System.Windows.Forms.ScrollEventHandler(this.leftplayervolume_Scroll);
            // 
            // rightplayervolume
            // 
            this.rightplayervolume.LargeChange = 1;
            this.rightplayervolume.Location = new System.Drawing.Point(142, 16);
            this.rightplayervolume.Name = "rightplayervolume";
            this.rightplayervolume.Size = new System.Drawing.Size(20, 115);
            this.rightplayervolume.TabIndex = 1;
            this.rightplayervolume.ValueChanged += new System.EventHandler(this.rightplayervolume_ValueChanged);
            // 
            // rightmastervolume
            // 
            this.rightmastervolume.LargeChange = 1;
            this.rightmastervolume.Location = new System.Drawing.Point(51, 16);
            this.rightmastervolume.Name = "rightmastervolume";
            this.rightmastervolume.Size = new System.Drawing.Size(20, 114);
            this.rightmastervolume.TabIndex = 1;
            this.rightmastervolume.ValueChanged += new System.EventHandler(this.rightmastervolume_ValueChanged);
            // 
            // leftmastervolume
            // 
            this.leftmastervolume.LargeChange = 1;
            this.leftmastervolume.Location = new System.Drawing.Point(15, 16);
            this.leftmastervolume.Name = "leftmastervolume";
            this.leftmastervolume.Size = new System.Drawing.Size(20, 115);
            this.leftmastervolume.TabIndex = 0;
            this.leftmastervolume.ValueChanged += new System.EventHandler(this.leftmastervolume_ValueChanged);
            // 
            // GroupBox5
            // 
            this.GroupBox5.Controls.Add(this.statusvalue2);
            this.GroupBox5.Controls.Add(this.statuslabel2);
            this.GroupBox5.Controls.Add(this.statusvalue1);
            this.GroupBox5.Controls.Add(this.statuslabel1);
            this.GroupBox5.Location = new System.Drawing.Point(12, 295);
            this.GroupBox5.Name = "GroupBox5";
            this.GroupBox5.Size = new System.Drawing.Size(271, 117);
            this.GroupBox5.TabIndex = 17;
            this.GroupBox5.TabStop = false;
            this.GroupBox5.Text = "Status";
            // 
            // statusvalue2
            // 
            this.statusvalue2.Location = new System.Drawing.Point(229, 16);
            this.statusvalue2.Name = "statusvalue2";
            this.statusvalue2.Size = new System.Drawing.Size(36, 91);
            this.statusvalue2.TabIndex = 3;
            // 
            // statuslabel2
            // 
            this.statuslabel2.Location = new System.Drawing.Point(125, 16);
            this.statuslabel2.Name = "statuslabel2";
            this.statuslabel2.Size = new System.Drawing.Size(98, 91);
            this.statuslabel2.TabIndex = 2;
            // 
            // statusvalue1
            // 
            this.statusvalue1.Location = new System.Drawing.Point(82, 16);
            this.statusvalue1.Name = "statusvalue1";
            this.statusvalue1.Size = new System.Drawing.Size(37, 91);
            this.statusvalue1.TabIndex = 1;
            this.statusvalue1.TextAlign = System.Drawing.ContentAlignment.TopRight;
            // 
            // statuslabel1
            // 
            this.statuslabel1.Location = new System.Drawing.Point(6, 16);
            this.statuslabel1.Name = "statuslabel1";
            this.statuslabel1.Size = new System.Drawing.Size(70, 91);
            this.statuslabel1.TabIndex = 0;
            // 
            // leftvu
            // 
            this.leftvu.Location = new System.Drawing.Point(673, 228);
            this.leftvu.Name = "leftvu";
            this.leftvu.Size = new System.Drawing.Size(99, 25);
            this.leftvu.Step = 1;
            this.leftvu.Style = System.Windows.Forms.ProgressBarStyle.Continuous;
            this.leftvu.TabIndex = 18;
            // 
            // rightvu
            // 
            this.rightvu.Location = new System.Drawing.Point(673, 259);
            this.rightvu.Name = "rightvu";
            this.rightvu.Size = new System.Drawing.Size(99, 23);
            this.rightvu.Step = 1;
            this.rightvu.Style = System.Windows.Forms.ProgressBarStyle.Continuous;
            this.rightvu.TabIndex = 19;
            // 
            // Timer2
            // 
            this.Timer2.Interval = 50;
            this.Timer2.Tick += new System.EventHandler(this.Timer2_Tick);
            // 
            // Button13
            // 
            this.Button13.Location = new System.Drawing.Point(12, 182);
            this.Button13.Name = "Button13";
            this.Button13.Size = new System.Drawing.Size(63, 23);
            this.Button13.TabIndex = 20;
            this.Button13.Text = "Fade in";
            this.Button13.UseVisualStyleBackColor = true;
            this.Button13.Click += new System.EventHandler(this.Button13_Click);
            // 
            // Button14
            // 
            this.Button14.Location = new System.Drawing.Point(81, 182);
            this.Button14.Name = "Button14";
            this.Button14.Size = new System.Drawing.Size(63, 23);
            this.Button14.TabIndex = 21;
            this.Button14.Text = "Fade out";
            this.Button14.UseVisualStyleBackColor = true;
            this.Button14.Click += new System.EventHandler(this.Button14_Click);
            // 
            // GroupBox6
            // 
            this.GroupBox6.Controls.Add(this.VScrollBar11);
            this.GroupBox6.Controls.Add(this.VScrollBar10);
            this.GroupBox6.Controls.Add(this.VScrollBar9);
            this.GroupBox6.Controls.Add(this.VScrollBar8);
            this.GroupBox6.Controls.Add(this.VScrollBar7);
            this.GroupBox6.Controls.Add(this.VScrollBar6);
            this.GroupBox6.Controls.Add(this.VScrollBar5);
            this.GroupBox6.Controls.Add(this.VScrollBar4);
            this.GroupBox6.Controls.Add(this.VScrollBar3);
            this.GroupBox6.Controls.Add(this.VScrollBar2);
            this.GroupBox6.Controls.Add(this.VScrollBar1);
            this.GroupBox6.Controls.Add(this.CheckBox1);
            this.GroupBox6.Location = new System.Drawing.Point(289, 269);
            this.GroupBox6.Name = "GroupBox6";
            this.GroupBox6.Size = new System.Drawing.Size(297, 143);
            this.GroupBox6.TabIndex = 22;
            this.GroupBox6.TabStop = false;
            this.GroupBox6.Text = "Equalizer";
            // 
            // VScrollBar11
            // 
            this.VScrollBar11.LargeChange = 1;
            this.VScrollBar11.Location = new System.Drawing.Point(270, 38);
            this.VScrollBar11.Maximum = 40;
            this.VScrollBar11.Name = "VScrollBar11";
            this.VScrollBar11.Size = new System.Drawing.Size(16, 95);
            this.VScrollBar11.TabIndex = 11;
            this.VScrollBar11.Value = 20;
            this.VScrollBar11.ValueChanged += new System.EventHandler(this.VScrollBar11_ValueChanged);
            // 
            // VScrollBar10
            // 
            this.VScrollBar10.LargeChange = 1;
            this.VScrollBar10.Location = new System.Drawing.Point(244, 38);
            this.VScrollBar10.Maximum = 40;
            this.VScrollBar10.Name = "VScrollBar10";
            this.VScrollBar10.Size = new System.Drawing.Size(16, 95);
            this.VScrollBar10.TabIndex = 10;
            this.VScrollBar10.Value = 20;
            this.VScrollBar10.ValueChanged += new System.EventHandler(this.VScrollBar10_ValueChanged);
            // 
            // VScrollBar9
            // 
            this.VScrollBar9.LargeChange = 1;
            this.VScrollBar9.Location = new System.Drawing.Point(218, 38);
            this.VScrollBar9.Maximum = 40;
            this.VScrollBar9.Name = "VScrollBar9";
            this.VScrollBar9.Size = new System.Drawing.Size(16, 95);
            this.VScrollBar9.TabIndex = 9;
            this.VScrollBar9.Value = 20;
            this.VScrollBar9.ValueChanged += new System.EventHandler(this.VScrollBar9_ValueChanged);
            // 
            // VScrollBar8
            // 
            this.VScrollBar8.LargeChange = 1;
            this.VScrollBar8.Location = new System.Drawing.Point(192, 38);
            this.VScrollBar8.Maximum = 40;
            this.VScrollBar8.Name = "VScrollBar8";
            this.VScrollBar8.Size = new System.Drawing.Size(16, 95);
            this.VScrollBar8.TabIndex = 8;
            this.VScrollBar8.Value = 20;
            this.VScrollBar8.ValueChanged += new System.EventHandler(this.VScrollBar8_ValueChanged);
            // 
            // VScrollBar7
            // 
            this.VScrollBar7.LargeChange = 1;
            this.VScrollBar7.Location = new System.Drawing.Point(166, 38);
            this.VScrollBar7.Maximum = 40;
            this.VScrollBar7.Name = "VScrollBar7";
            this.VScrollBar7.Size = new System.Drawing.Size(16, 95);
            this.VScrollBar7.TabIndex = 7;
            this.VScrollBar7.Value = 20;
            this.VScrollBar7.ValueChanged += new System.EventHandler(this.VScrollBar7_ValueChanged);
            // 
            // VScrollBar6
            // 
            this.VScrollBar6.LargeChange = 1;
            this.VScrollBar6.Location = new System.Drawing.Point(140, 38);
            this.VScrollBar6.Maximum = 40;
            this.VScrollBar6.Name = "VScrollBar6";
            this.VScrollBar6.Size = new System.Drawing.Size(16, 95);
            this.VScrollBar6.TabIndex = 6;
            this.VScrollBar6.Value = 20;
            this.VScrollBar6.ValueChanged += new System.EventHandler(this.VScrollBar6_ValueChanged);
            // 
            // VScrollBar5
            // 
            this.VScrollBar5.LargeChange = 1;
            this.VScrollBar5.Location = new System.Drawing.Point(114, 38);
            this.VScrollBar5.Maximum = 40;
            this.VScrollBar5.Name = "VScrollBar5";
            this.VScrollBar5.Size = new System.Drawing.Size(16, 95);
            this.VScrollBar5.TabIndex = 5;
            this.VScrollBar5.Value = 20;
            this.VScrollBar5.ValueChanged += new System.EventHandler(this.VScrollBar5_ValueChanged);
            // 
            // VScrollBar4
            // 
            this.VScrollBar4.LargeChange = 1;
            this.VScrollBar4.Location = new System.Drawing.Point(88, 38);
            this.VScrollBar4.Maximum = 40;
            this.VScrollBar4.Name = "VScrollBar4";
            this.VScrollBar4.Size = new System.Drawing.Size(16, 95);
            this.VScrollBar4.TabIndex = 4;
            this.VScrollBar4.Value = 20;
            this.VScrollBar4.ValueChanged += new System.EventHandler(this.VScrollBar4_ValueChanged);
            // 
            // VScrollBar3
            // 
            this.VScrollBar3.LargeChange = 1;
            this.VScrollBar3.Location = new System.Drawing.Point(62, 38);
            this.VScrollBar3.Maximum = 40;
            this.VScrollBar3.Name = "VScrollBar3";
            this.VScrollBar3.Size = new System.Drawing.Size(16, 95);
            this.VScrollBar3.TabIndex = 3;
            this.VScrollBar3.Value = 20;
            this.VScrollBar3.ValueChanged += new System.EventHandler(this.VScrollBar3_ValueChanged);
            // 
            // VScrollBar2
            // 
            this.VScrollBar2.LargeChange = 1;
            this.VScrollBar2.Location = new System.Drawing.Point(36, 38);
            this.VScrollBar2.Maximum = 40;
            this.VScrollBar2.Name = "VScrollBar2";
            this.VScrollBar2.Size = new System.Drawing.Size(16, 95);
            this.VScrollBar2.TabIndex = 2;
            this.VScrollBar2.Value = 20;
            this.VScrollBar2.ValueChanged += new System.EventHandler(this.VScrollBar2_ValueChanged);
            // 
            // VScrollBar1
            // 
            this.VScrollBar1.LargeChange = 1;
            this.VScrollBar1.Location = new System.Drawing.Point(9, 38);
            this.VScrollBar1.Maximum = 40;
            this.VScrollBar1.Name = "VScrollBar1";
            this.VScrollBar1.Size = new System.Drawing.Size(16, 95);
            this.VScrollBar1.TabIndex = 1;
            this.VScrollBar1.Value = 20;
            this.VScrollBar1.ValueChanged += new System.EventHandler(this.VScrollBar1_ValueChanged);
            // 
            // CheckBox1
            // 
            this.CheckBox1.AutoSize = true;
            this.CheckBox1.Location = new System.Drawing.Point(9, 19);
            this.CheckBox1.Name = "CheckBox1";
            this.CheckBox1.Size = new System.Drawing.Size(59, 17);
            this.CheckBox1.TabIndex = 0;
            this.CheckBox1.Text = "Enable";
            this.CheckBox1.UseVisualStyleBackColor = true;
            this.CheckBox1.CheckedChanged += new System.EventHandler(this.CheckBox1_CheckedChanged);
            // 
            // Button15
            // 
            this.Button15.Location = new System.Drawing.Point(220, 155);
            this.Button15.Name = "Button15";
            this.Button15.Size = new System.Drawing.Size(64, 23);
            this.Button15.TabIndex = 23;
            this.Button15.Text = "Echo";
            this.Button15.UseVisualStyleBackColor = true;
            this.Button15.Click += new System.EventHandler(this.Button15_Click);
            // 
            // GroupBox7
            // 
            this.GroupBox7.Controls.Add(this.VScrollBar14);
            this.GroupBox7.Controls.Add(this.VScrollBar13);
            this.GroupBox7.Controls.Add(this.VScrollBar12);
            this.GroupBox7.Location = new System.Drawing.Point(592, 148);
            this.GroupBox7.Name = "GroupBox7";
            this.GroupBox7.Size = new System.Drawing.Size(80, 141);
            this.GroupBox7.TabIndex = 24;
            this.GroupBox7.TabStop = false;
            this.GroupBox7.Text = "PTR";
            // 
            // VScrollBar14
            // 
            this.VScrollBar14.LargeChange = 1;
            this.VScrollBar14.Location = new System.Drawing.Point(51, 16);
            this.VScrollBar14.Maximum = 200;
            this.VScrollBar14.Name = "VScrollBar14";
            this.VScrollBar14.Size = new System.Drawing.Size(14, 115);
            this.VScrollBar14.TabIndex = 2;
            this.VScrollBar14.Value = 100;
            this.VScrollBar14.ValueChanged += new System.EventHandler(this.VScrollBar14_ValueChanged);
            // 
            // VScrollBar13
            // 
            this.VScrollBar13.LargeChange = 1;
            this.VScrollBar13.Location = new System.Drawing.Point(28, 16);
            this.VScrollBar13.Maximum = 200;
            this.VScrollBar13.Name = "VScrollBar13";
            this.VScrollBar13.Size = new System.Drawing.Size(14, 115);
            this.VScrollBar13.TabIndex = 1;
            this.VScrollBar13.Value = 100;
            this.VScrollBar13.ValueChanged += new System.EventHandler(this.VScrollBar13_ValueChanged);
            // 
            // VScrollBar12
            // 
            this.VScrollBar12.LargeChange = 1;
            this.VScrollBar12.Location = new System.Drawing.Point(8, 16);
            this.VScrollBar12.Maximum = 200;
            this.VScrollBar12.Name = "VScrollBar12";
            this.VScrollBar12.Size = new System.Drawing.Size(14, 115);
            this.VScrollBar12.TabIndex = 0;
            this.VScrollBar12.Value = 100;
            this.VScrollBar12.ValueChanged += new System.EventHandler(this.VScrollBar12_ValueChanged);
            // 
            // Button16
            // 
            this.Button16.Location = new System.Drawing.Point(220, 182);
            this.Button16.Name = "Button16";
            this.Button16.Size = new System.Drawing.Size(63, 23);
            this.Button16.TabIndex = 25;
            this.Button16.Text = "Side cut";
            this.Button16.UseVisualStyleBackColor = true;
            this.Button16.Click += new System.EventHandler(this.Button16_Click);
            // 
            // GroupBox8
            // 
            this.GroupBox8.Controls.Add(this.checkBox3);
            this.GroupBox8.Controls.Add(this.CheckBox2);
            this.GroupBox8.Controls.Add(this.ComboBox3);
            this.GroupBox8.Controls.Add(this.ComboBox2);
            this.GroupBox8.Controls.Add(this.FFTLinear);
            this.GroupBox8.Controls.Add(this.ComboBox1);
            this.GroupBox8.Controls.Add(this.FFTEnabled);
            this.GroupBox8.Controls.Add(this.PictureBox1);
            this.GroupBox8.Location = new System.Drawing.Point(8, 418);
            this.GroupBox8.Name = "GroupBox8";
            this.GroupBox8.Size = new System.Drawing.Size(578, 152);
            this.GroupBox8.TabIndex = 27;
            this.GroupBox8.TabStop = false;
            this.GroupBox8.Text = "FFT";
            // 
            // checkBox3
            // 
            this.checkBox3.AutoSize = true;
            this.checkBox3.Checked = true;
            this.checkBox3.CheckState = System.Windows.Forms.CheckState.Checked;
            this.checkBox3.Location = new System.Drawing.Point(178, 130);
            this.checkBox3.Name = "checkBox3";
            this.checkBox3.Size = new System.Drawing.Size(53, 17);
            this.checkBox3.TabIndex = 7;
            this.checkBox3.Text = "Scale";
            this.checkBox3.UseVisualStyleBackColor = true;
            this.checkBox3.CheckedChanged += new System.EventHandler(this.checkBox3_CheckedChanged);
            // 
            // CheckBox2
            // 
            this.CheckBox2.AutoSize = true;
            this.CheckBox2.Checked = true;
            this.CheckBox2.CheckState = System.Windows.Forms.CheckState.Checked;
            this.CheckBox2.Location = new System.Drawing.Point(127, 130);
            this.CheckBox2.Name = "CheckBox2";
            this.CheckBox2.Size = new System.Drawing.Size(45, 17);
            this.CheckBox2.TabIndex = 6;
            this.CheckBox2.Text = "Grid";
            this.CheckBox2.UseVisualStyleBackColor = true;
            this.CheckBox2.CheckedChanged += new System.EventHandler(this.CheckBox2_CheckedChanged);
            // 
            // ComboBox3
            // 
            this.ComboBox3.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.ComboBox3.FormattingEnabled = true;
            this.ComboBox3.Items.AddRange(new object[] {
            "Rectangular",
            "Hamming",
            "Hann",
            "Cosine",
            "Lanczos",
            "Bartlett",
            "Triangular",
            "Gauss",
            "Bartlett-Hann",
            "Blackman",
            "Nuttall",
            "Blackman-Harris",
            "Blackman-Nuttall",
            "Flat-Top"});
            this.ComboBox3.Location = new System.Drawing.Point(395, 128);
            this.ComboBox3.Name = "ComboBox3";
            this.ComboBox3.Size = new System.Drawing.Size(107, 21);
            this.ComboBox3.TabIndex = 5;
            this.ComboBox3.SelectedIndexChanged += new System.EventHandler(this.ComboBox3_SelectedIndexChanged);
            // 
            // ComboBox2
            // 
            this.ComboBox2.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.ComboBox2.FormattingEnabled = true;
            this.ComboBox2.Items.AddRange(new object[] {
            "4",
            "8",
            "16",
            "32",
            "64",
            "128",
            "256",
            "512",
            "1204",
            "2048",
            "4096"});
            this.ComboBox2.Location = new System.Drawing.Point(509, 128);
            this.ComboBox2.Name = "ComboBox2";
            this.ComboBox2.Size = new System.Drawing.Size(59, 21);
            this.ComboBox2.TabIndex = 4;
            this.ComboBox2.SelectedIndexChanged += new System.EventHandler(this.ComboBox2_SelectedIndexChanged);
            // 
            // FFTLinear
            // 
            this.FFTLinear.AutoSize = true;
            this.FFTLinear.Location = new System.Drawing.Point(67, 130);
            this.FFTLinear.Name = "FFTLinear";
            this.FFTLinear.Size = new System.Drawing.Size(55, 17);
            this.FFTLinear.TabIndex = 3;
            this.FFTLinear.Text = "Linear";
            this.FFTLinear.UseVisualStyleBackColor = true;
            this.FFTLinear.CheckedChanged += new System.EventHandler(this.FFTLinear_CheckedChanged);
            // 
            // ComboBox1
            // 
            this.ComboBox1.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.ComboBox1.FormattingEnabled = true;
            this.ComboBox1.Items.AddRange(new object[] {
            "Lines (Left On Top)",
            "Lines (Right On Top)",
            "Area (Left On Top)",
            "Area (Right On Top)",
            "Bars (Left On Top)",
            "Bars (Right OnTop)",
            "Spectrum"});
            this.ComboBox1.Location = new System.Drawing.Point(269, 128);
            this.ComboBox1.Name = "ComboBox1";
            this.ComboBox1.Size = new System.Drawing.Size(116, 21);
            this.ComboBox1.TabIndex = 2;
            this.ComboBox1.SelectedIndexChanged += new System.EventHandler(this.ComboBox1_SelectedIndexChanged);
            // 
            // FFTEnabled
            // 
            this.FFTEnabled.AutoSize = true;
            this.FFTEnabled.Checked = true;
            this.FFTEnabled.CheckState = System.Windows.Forms.CheckState.Checked;
            this.FFTEnabled.Location = new System.Drawing.Point(6, 130);
            this.FFTEnabled.Name = "FFTEnabled";
            this.FFTEnabled.Size = new System.Drawing.Size(59, 17);
            this.FFTEnabled.TabIndex = 1;
            this.FFTEnabled.Text = "Enable";
            this.FFTEnabled.UseVisualStyleBackColor = true;
            // 
            // PictureBox1
            // 
            this.PictureBox1.BackColor = System.Drawing.Color.Black;
            this.PictureBox1.Location = new System.Drawing.Point(6, 11);
            this.PictureBox1.Name = "PictureBox1";
            this.PictureBox1.Size = new System.Drawing.Size(566, 114);
            this.PictureBox1.TabIndex = 0;
            this.PictureBox1.TabStop = false;
            this.PictureBox1.Paint += new System.Windows.Forms.PaintEventHandler(this.PictureBox1_Paint);
            // 
            // Button17
            // 
            this.Button17.Location = new System.Drawing.Point(152, 237);
            this.Button17.Name = "Button17";
            this.Button17.Size = new System.Drawing.Size(132, 23);
            this.Button17.TabIndex = 29;
            this.Button17.Text = "Detect BPM";
            this.Button17.UseVisualStyleBackColor = true;
            this.Button17.Click += new System.EventHandler(this.Button17_Click);
            // 
            // callback_text
            // 
            this.callback_text.Location = new System.Drawing.Point(678, 158);
            this.callback_text.Name = "callback_text";
            this.callback_text.Size = new System.Drawing.Size(98, 53);
            this.callback_text.TabIndex = 30;
            // 
            // button18
            // 
            this.button18.Location = new System.Drawing.Point(151, 1);
            this.button18.Name = "button18";
            this.button18.Size = new System.Drawing.Size(132, 21);
            this.button18.TabIndex = 31;
            this.button18.Text = "Add file";
            this.button18.UseVisualStyleBackColor = true;
            this.button18.Click += new System.EventHandler(this.button18_Click);
            // 
            // pictureBox2
            // 
            this.pictureBox2.Location = new System.Drawing.Point(6, 19);
            this.pictureBox2.Name = "pictureBox2";
            this.pictureBox2.Size = new System.Drawing.Size(177, 241);
            this.pictureBox2.TabIndex = 32;
            this.pictureBox2.TabStop = false;
            // 
            // saveFileDialog1
            // 
            this.saveFileDialog1.Filter = "Wave File|*.wav";
            this.saveFileDialog1.Title = "Save to wave file";
            this.saveFileDialog1.FileOk += new System.ComponentModel.CancelEventHandler(this.saveFileDialog1_FileOk);
            // 
            // groupBox4
            // 
            this.groupBox4.Controls.Add(this.pictureBox2);
            this.groupBox4.Location = new System.Drawing.Point(595, 299);
            this.groupBox4.Name = "groupBox4";
            this.groupBox4.Size = new System.Drawing.Size(189, 266);
            this.groupBox4.TabIndex = 37;
            this.groupBox4.TabStop = false;
            this.groupBox4.Text = "ID3 embeded picture";
            // 
            // groupBox10
            // 
            this.groupBox10.Controls.Add(this.Button20);
            this.groupBox10.Controls.Add(this.CheckBox4);
            this.groupBox10.Controls.Add(this.Label2);
            this.groupBox10.Controls.Add(this.Label1);
            this.groupBox10.Controls.Add(this.ComboBox5);
            this.groupBox10.Controls.Add(this.ComboBox4);
            this.groupBox10.Location = new System.Drawing.Point(12, 55);
            this.groupBox10.Name = "groupBox10";
            this.groupBox10.Size = new System.Drawing.Size(272, 66);
            this.groupBox10.TabIndex = 38;
            this.groupBox10.TabStop = false;
            this.groupBox10.Text = "Recording";
            // 
            // Button20
            // 
            this.Button20.Location = new System.Drawing.Point(10, 42);
            this.Button20.Name = "Button20";
            this.Button20.Size = new System.Drawing.Size(118, 21);
            this.Button20.TabIndex = 8;
            this.Button20.Text = "Record";
            this.Button20.UseVisualStyleBackColor = true;
            this.Button20.Click += new System.EventHandler(this.Button20_Click_1);
            // 
            // CheckBox4
            // 
            this.CheckBox4.AutoSize = true;
            this.CheckBox4.Location = new System.Drawing.Point(149, 44);
            this.CheckBox4.Name = "CheckBox4";
            this.CheckBox4.Size = new System.Drawing.Size(111, 17);
            this.CheckBox4.TabIndex = 7;
            this.CheckBox4.Text = "Play to soundcard";
            this.CheckBox4.UseVisualStyleBackColor = true;
            // 
            // Label2
            // 
            this.Label2.AutoSize = true;
            this.Label2.Location = new System.Drawing.Point(133, 22);
            this.Label2.Name = "Label2";
            this.Label2.Size = new System.Drawing.Size(32, 13);
            this.Label2.TabIndex = 6;
            this.Label2.Text = "Dest:";
            // 
            // Label1
            // 
            this.Label1.AutoSize = true;
            this.Label1.Location = new System.Drawing.Point(4, 22);
            this.Label1.Name = "Label1";
            this.Label1.Size = new System.Drawing.Size(26, 13);
            this.Label1.TabIndex = 5;
            this.Label1.Text = "Src:";
            // 
            // ComboBox5
            // 
            this.ComboBox5.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.ComboBox5.FormattingEnabled = true;
            this.ComboBox5.Items.AddRange(new object[] {
            "Soundcard",
            "Mp3 File",
            "Ogg File",
            "FLAC File",
            "Flac Ogg File",
            "AAC file",
            "Wav File",
            "PCM File"});
            this.ComboBox5.Location = new System.Drawing.Point(171, 19);
            this.ComboBox5.Name = "ComboBox5";
            this.ComboBox5.Size = new System.Drawing.Size(88, 21);
            this.ComboBox5.TabIndex = 4;
            // 
            // ComboBox4
            // 
            this.ComboBox4.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.ComboBox4.FormattingEnabled = true;
            this.ComboBox4.Items.AddRange(new object[] {
            "Line In",
            "Microphone",
            "CD Audio",
            "Midi"});
            this.ComboBox4.Location = new System.Drawing.Point(36, 19);
            this.ComboBox4.Name = "ComboBox4";
            this.ComboBox4.Size = new System.Drawing.Size(88, 21);
            this.ComboBox4.TabIndex = 3;
            // 
            // GroupBox9
            // 
            this.GroupBox9.Controls.Add(this.Label16);
            this.GroupBox9.Controls.Add(this.Label15);
            this.GroupBox9.Controls.Add(this.Label14);
            this.GroupBox9.Controls.Add(this.Label13);
            this.GroupBox9.Controls.Add(this.Label12);
            this.GroupBox9.Controls.Add(this.Label11);
            this.GroupBox9.Controls.Add(this.Label10);
            this.GroupBox9.Controls.Add(this.Label9);
            this.GroupBox9.Controls.Add(this.Label8);
            this.GroupBox9.Controls.Add(this.Label7);
            this.GroupBox9.Controls.Add(this.Label6);
            this.GroupBox9.Controls.Add(this.Label5);
            this.GroupBox9.Controls.Add(this.Label4);
            this.GroupBox9.Controls.Add(this.Label3);
            this.GroupBox9.Location = new System.Drawing.Point(289, 118);
            this.GroupBox9.Name = "GroupBox9";
            this.GroupBox9.Size = new System.Drawing.Size(296, 145);
            this.GroupBox9.TabIndex = 39;
            this.GroupBox9.TabStop = false;
            this.GroupBox9.Text = "ID3";
            // 
            // Label16
            // 
            this.Label16.AutoSize = true;
            this.Label16.Location = new System.Drawing.Point(6, 126);
            this.Label16.Name = "Label16";
            this.Label16.Size = new System.Drawing.Size(54, 13);
            this.Label16.TabIndex = 14;
            this.Label16.Text = "Comment:";
            // 
            // Label15
            // 
            this.Label15.AutoSize = true;
            this.Label15.Location = new System.Drawing.Point(6, 107);
            this.Label15.Name = "Label15";
            this.Label15.Size = new System.Drawing.Size(50, 13);
            this.Label15.TabIndex = 13;
            this.Label15.Text = "Encoder:";
            // 
            // Label14
            // 
            this.Label14.AutoSize = true;
            this.Label14.Location = new System.Drawing.Point(6, 88);
            this.Label14.Name = "Label14";
            this.Label14.Size = new System.Drawing.Size(38, 13);
            this.Label14.TabIndex = 12;
            this.Label14.Text = "Track:";
            // 
            // Label13
            // 
            this.Label13.AutoSize = true;
            this.Label13.Location = new System.Drawing.Point(6, 69);
            this.Label13.Name = "Label13";
            this.Label13.Size = new System.Drawing.Size(32, 13);
            this.Label13.TabIndex = 11;
            this.Label13.Text = "Year:";
            // 
            // Label12
            // 
            this.Label12.AutoSize = true;
            this.Label12.Location = new System.Drawing.Point(6, 50);
            this.Label12.Name = "Label12";
            this.Label12.Size = new System.Drawing.Size(39, 13);
            this.Label12.TabIndex = 10;
            this.Label12.Text = "Album:";
            // 
            // Label11
            // 
            this.Label11.AutoSize = true;
            this.Label11.Location = new System.Drawing.Point(6, 31);
            this.Label11.Name = "Label11";
            this.Label11.Size = new System.Drawing.Size(33, 13);
            this.Label11.TabIndex = 9;
            this.Label11.Text = "Artist:";
            // 
            // Label10
            // 
            this.Label10.AutoSize = true;
            this.Label10.Location = new System.Drawing.Point(6, 12);
            this.Label10.Name = "Label10";
            this.Label10.Size = new System.Drawing.Size(30, 13);
            this.Label10.TabIndex = 8;
            this.Label10.Text = "Title:";
            // 
            // Label9
            // 
            this.Label9.Location = new System.Drawing.Point(62, 126);
            this.Label9.Name = "Label9";
            this.Label9.Size = new System.Drawing.Size(225, 16);
            this.Label9.TabIndex = 7;
            // 
            // Label8
            // 
            this.Label8.Location = new System.Drawing.Point(62, 107);
            this.Label8.Name = "Label8";
            this.Label8.Size = new System.Drawing.Size(225, 16);
            this.Label8.TabIndex = 6;
            // 
            // Label7
            // 
            this.Label7.Location = new System.Drawing.Point(62, 88);
            this.Label7.Name = "Label7";
            this.Label7.Size = new System.Drawing.Size(225, 16);
            this.Label7.TabIndex = 5;
            // 
            // Label6
            // 
            this.Label6.Location = new System.Drawing.Point(62, 69);
            this.Label6.Name = "Label6";
            this.Label6.Size = new System.Drawing.Size(225, 16);
            this.Label6.TabIndex = 4;
            // 
            // Label5
            // 
            this.Label5.Location = new System.Drawing.Point(62, 50);
            this.Label5.Name = "Label5";
            this.Label5.Size = new System.Drawing.Size(225, 16);
            this.Label5.TabIndex = 3;
            // 
            // Label4
            // 
            this.Label4.Location = new System.Drawing.Point(62, 31);
            this.Label4.Name = "Label4";
            this.Label4.Size = new System.Drawing.Size(225, 16);
            this.Label4.TabIndex = 2;
            // 
            // Label3
            // 
            this.Label3.Location = new System.Drawing.Point(62, 12);
            this.Label3.Name = "Label3";
            this.Label3.Size = new System.Drawing.Size(225, 16);
            this.Label3.TabIndex = 1;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(784, 569);
            this.Controls.Add(this.GroupBox9);
            this.Controls.Add(this.groupBox10);
            this.Controls.Add(this.groupBox4);
            this.Controls.Add(this.button18);
            this.Controls.Add(this.callback_text);
            this.Controls.Add(this.Button17);
            this.Controls.Add(this.GroupBox8);
            this.Controls.Add(this.Button16);
            this.Controls.Add(this.GroupBox7);
            this.Controls.Add(this.Button15);
            this.Controls.Add(this.GroupBox6);
            this.Controls.Add(this.Button14);
            this.Controls.Add(this.Button13);
            this.Controls.Add(this.rightvu);
            this.Controls.Add(this.leftvu);
            this.Controls.Add(this.GroupBox5);
            this.Controls.Add(this.GroupBox3);
            this.Controls.Add(this.GroupBox2);
            this.Controls.Add(this.Button12);
            this.Controls.Add(this.Button11);
            this.Controls.Add(this.Button10);
            this.Controls.Add(this.Button9);
            this.Controls.Add(this.ProgressBar1);
            this.Controls.Add(this.Button8);
            this.Controls.Add(this.GroupBox1);
            this.Controls.Add(this.Button7);
            this.Controls.Add(this.Button6);
            this.Controls.Add(this.Button5);
            this.Controls.Add(this.Button4);
            this.Controls.Add(this.Button3);
            this.Controls.Add(this.Button2);
            this.Controls.Add(this.Button1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MaximizeBox = false;
            this.Name = "Form1";
            this.Text = "libZPlay player";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.FormClosed += new System.Windows.Forms.FormClosedEventHandler(this.Form1_FormClosed);
            this.GroupBox1.ResumeLayout(false);
            this.GroupBox2.ResumeLayout(false);
            this.GroupBox3.ResumeLayout(false);
            this.GroupBox5.ResumeLayout(false);
            this.GroupBox6.ResumeLayout(false);
            this.GroupBox6.PerformLayout();
            this.GroupBox7.ResumeLayout(false);
            this.GroupBox8.ResumeLayout(false);
            this.GroupBox8.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.PictureBox1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox2)).EndInit();
            this.groupBox4.ResumeLayout(false);
            this.groupBox10.ResumeLayout(false);
            this.groupBox10.PerformLayout();
            this.GroupBox9.ResumeLayout(false);
            this.GroupBox9.PerformLayout();
            this.ResumeLayout(false);

		}
		internal System.Windows.Forms.Button Button1;
		internal System.Windows.Forms.OpenFileDialog OpenFileDialog1;
		internal System.Windows.Forms.Button Button2;
		internal System.Windows.Forms.Button Button3;
		internal System.Windows.Forms.Button Button4;
		internal System.Windows.Forms.Button Button5;
		internal System.Windows.Forms.Button Button6;
		internal System.Windows.Forms.Button Button7;
		internal System.Windows.Forms.GroupBox GroupBox1;
		internal System.Windows.Forms.Button Button8;
		internal System.Windows.Forms.ProgressBar ProgressBar1;
		internal System.Windows.Forms.Timer Timer1;
		internal System.Windows.Forms.Button Button9;
		internal System.Windows.Forms.Button Button10;
		internal System.Windows.Forms.Button Button11;
		internal System.Windows.Forms.Button Button12;
		internal System.Windows.Forms.GroupBox GroupBox2;
		internal System.Windows.Forms.Label position;
        internal System.Windows.Forms.GroupBox GroupBox3;
		internal System.Windows.Forms.VScrollBar rightmastervolume;
		internal System.Windows.Forms.VScrollBar leftmastervolume;
		internal System.Windows.Forms.VScrollBar rightplayervolume;
		internal System.Windows.Forms.VScrollBar leftplayervolume;
		internal System.Windows.Forms.GroupBox GroupBox5;
		internal System.Windows.Forms.Label statuslabel1;
		internal System.Windows.Forms.Label statusvalue1;
		internal System.Windows.Forms.Label statuslabel2;
		internal System.Windows.Forms.Label statusvalue2;
		internal System.Windows.Forms.ProgressBar leftvu;
		internal System.Windows.Forms.ProgressBar rightvu;
		internal System.Windows.Forms.Timer Timer2;
		internal System.Windows.Forms.Button Button13;
		internal System.Windows.Forms.Button Button14;
		internal System.Windows.Forms.GroupBox GroupBox6;
		internal System.Windows.Forms.CheckBox CheckBox1;
		internal System.Windows.Forms.VScrollBar VScrollBar1;
		internal System.Windows.Forms.VScrollBar VScrollBar11;
		internal System.Windows.Forms.VScrollBar VScrollBar10;
		internal System.Windows.Forms.VScrollBar VScrollBar9;
		internal System.Windows.Forms.VScrollBar VScrollBar8;
		internal System.Windows.Forms.VScrollBar VScrollBar7;
		internal System.Windows.Forms.VScrollBar VScrollBar6;
		internal System.Windows.Forms.VScrollBar VScrollBar5;
		internal System.Windows.Forms.VScrollBar VScrollBar4;
		internal System.Windows.Forms.VScrollBar VScrollBar3;
		internal System.Windows.Forms.VScrollBar VScrollBar2;
		internal System.Windows.Forms.Button Button15;
		internal System.Windows.Forms.GroupBox GroupBox7;
		internal System.Windows.Forms.VScrollBar VScrollBar14;
		internal System.Windows.Forms.VScrollBar VScrollBar13;
		internal System.Windows.Forms.VScrollBar VScrollBar12;
		internal System.Windows.Forms.Button Button16;
		internal System.Windows.Forms.GroupBox GroupBox8;
		internal System.Windows.Forms.PictureBox PictureBox1;
		internal System.Windows.Forms.CheckBox FFTEnabled;
		internal System.Windows.Forms.ComboBox ComboBox1;
        internal System.Windows.Forms.CheckBox FFTLinear;
		internal System.Windows.Forms.ComboBox ComboBox2;
		internal System.Windows.Forms.ComboBox ComboBox3;
		internal System.Windows.Forms.CheckBox CheckBox2;
		internal System.Windows.Forms.Button Button17;
		internal System.Windows.Forms.Label descr;
		internal System.Windows.Forms.Label descr1;
		internal System.Windows.Forms.Label callback_text;
        internal Button button18;
        private CheckBox checkBox3;
        private PictureBox pictureBox2;
        private SaveFileDialog saveFileDialog1;
        private GroupBox groupBox4;
        internal GroupBox groupBox10;
        internal Button Button20;
        internal CheckBox CheckBox4;
        internal Label Label2;
        internal Label Label1;
        internal ComboBox ComboBox5;
        internal ComboBox ComboBox4;
        internal GroupBox GroupBox9;
        internal Label Label16;
        internal Label Label15;
        internal Label Label14;
        internal Label Label13;
        internal Label Label12;
        internal Label Label11;
        internal Label Label10;
        internal Label Label9;
        internal Label Label8;
        internal Label Label7;
        internal Label Label6;
        internal Label Label5;
        internal Label Label4;
        internal Label Label3;

	}

} //end of root namespace