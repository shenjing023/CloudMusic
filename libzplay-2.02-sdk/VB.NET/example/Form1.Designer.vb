Imports Microsoft.VisualBasic
Imports System
Imports System.Collections
Imports System.Collections.Generic
Imports System.Data
Imports System.Drawing
Imports System.Diagnostics
Imports System.Windows.Forms
Imports System.Linq
Imports System.Xml.Linq

Namespace libwmp3x_player
    ''' <summary>
    ''' Form1
    ''' </summary>
    ''' <remarks></remarks>
    <Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
    Partial Public Class Form1
        Inherits System.Windows.Forms.Form

        'Form overrides dispose to clean up the component list.
        ''' <summary>
        ''' Dispose
        ''' </summary>
        ''' <param name="disposing"></param>
        ''' <remarks></remarks>
        <System.Diagnostics.DebuggerNonUserCode()> _
        Protected Overloads Overrides Sub Dispose(ByVal disposing As Boolean)
            Try
                If disposing AndAlso components IsNot Nothing Then
                    components.Dispose()
                End If
            Finally
                MyBase.Dispose(disposing)
            End Try
        End Sub

        'Required by the Windows Form Designer
        Private components As System.ComponentModel.IContainer

        'NOTE: The following procedure is required by the Windows Form Designer
        'It can be modified using the Windows Form Designer.  
        'Do not modify it using the code editor.
        <System.Diagnostics.DebuggerStepThrough()> _
        Private Sub InitializeComponent()
            Me.components = New System.ComponentModel.Container
            Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(Form1))
            Me.Button1 = New System.Windows.Forms.Button
            Me.OpenFileDialog1 = New System.Windows.Forms.OpenFileDialog
            Me.Button2 = New System.Windows.Forms.Button
            Me.Button3 = New System.Windows.Forms.Button
            Me.Button4 = New System.Windows.Forms.Button
            Me.Button5 = New System.Windows.Forms.Button
            Me.Button6 = New System.Windows.Forms.Button
            Me.Button7 = New System.Windows.Forms.Button
            Me.GroupBox1 = New System.Windows.Forms.GroupBox
            Me.descr1 = New System.Windows.Forms.Label
            Me.descr = New System.Windows.Forms.Label
            Me.Button8 = New System.Windows.Forms.Button
            Me.ProgressBar1 = New System.Windows.Forms.ProgressBar
            Me.Timer1 = New System.Windows.Forms.Timer(Me.components)
            Me.Button9 = New System.Windows.Forms.Button
            Me.Button10 = New System.Windows.Forms.Button
            Me.Button11 = New System.Windows.Forms.Button
            Me.Button12 = New System.Windows.Forms.Button
            Me.GroupBox2 = New System.Windows.Forms.GroupBox
            Me.position = New System.Windows.Forms.Label
            Me.GroupBox3 = New System.Windows.Forms.GroupBox
            Me.rightplayervolume = New System.Windows.Forms.VScrollBar
            Me.rightmastervolume = New System.Windows.Forms.VScrollBar
            Me.leftplayervolume = New System.Windows.Forms.VScrollBar
            Me.leftmastervolume = New System.Windows.Forms.VScrollBar
            Me.GroupBox5 = New System.Windows.Forms.GroupBox
            Me.statusvalue2 = New System.Windows.Forms.Label
            Me.statuslabel2 = New System.Windows.Forms.Label
            Me.statusvalue1 = New System.Windows.Forms.Label
            Me.statuslabel1 = New System.Windows.Forms.Label
            Me.leftvu = New System.Windows.Forms.ProgressBar
            Me.rightvu = New System.Windows.Forms.ProgressBar
            Me.Timer2 = New System.Windows.Forms.Timer(Me.components)
            Me.Button13 = New System.Windows.Forms.Button
            Me.Button14 = New System.Windows.Forms.Button
            Me.GroupBox6 = New System.Windows.Forms.GroupBox
            Me.VScrollBar11 = New System.Windows.Forms.VScrollBar
            Me.VScrollBar10 = New System.Windows.Forms.VScrollBar
            Me.VScrollBar9 = New System.Windows.Forms.VScrollBar
            Me.VScrollBar8 = New System.Windows.Forms.VScrollBar
            Me.VScrollBar7 = New System.Windows.Forms.VScrollBar
            Me.VScrollBar6 = New System.Windows.Forms.VScrollBar
            Me.VScrollBar5 = New System.Windows.Forms.VScrollBar
            Me.VScrollBar4 = New System.Windows.Forms.VScrollBar
            Me.VScrollBar3 = New System.Windows.Forms.VScrollBar
            Me.VScrollBar2 = New System.Windows.Forms.VScrollBar
            Me.VScrollBar1 = New System.Windows.Forms.VScrollBar
            Me.CheckBox1 = New System.Windows.Forms.CheckBox
            Me.Button15 = New System.Windows.Forms.Button
            Me.GroupBox7 = New System.Windows.Forms.GroupBox
            Me.VScrollBar14 = New System.Windows.Forms.VScrollBar
            Me.VScrollBar13 = New System.Windows.Forms.VScrollBar
            Me.VScrollBar12 = New System.Windows.Forms.VScrollBar
            Me.Button16 = New System.Windows.Forms.Button
            Me.GroupBox8 = New System.Windows.Forms.GroupBox
            Me.CheckBox3 = New System.Windows.Forms.CheckBox
            Me.CheckBox2 = New System.Windows.Forms.CheckBox
            Me.ComboBox3 = New System.Windows.Forms.ComboBox
            Me.ComboBox2 = New System.Windows.Forms.ComboBox
            Me.FFTLinear = New System.Windows.Forms.CheckBox
            Me.ComboBox1 = New System.Windows.Forms.ComboBox
            Me.FFTEnabled = New System.Windows.Forms.CheckBox
            Me.PictureBox1 = New System.Windows.Forms.PictureBox
            Me.GroupBox9 = New System.Windows.Forms.GroupBox
            Me.Button17 = New System.Windows.Forms.Button
            Me.callback_text = New System.Windows.Forms.Label
            Me.Button18 = New System.Windows.Forms.Button
            Me.PictureBox2 = New System.Windows.Forms.PictureBox
            Me.SaveFileDialog1 = New System.Windows.Forms.SaveFileDialog
            Me.GroupBox4 = New System.Windows.Forms.GroupBox
            Me.Button20 = New System.Windows.Forms.Button
            Me.CheckBox4 = New System.Windows.Forms.CheckBox
            Me.Label2 = New System.Windows.Forms.Label
            Me.Label1 = New System.Windows.Forms.Label
            Me.ComboBox5 = New System.Windows.Forms.ComboBox
            Me.ComboBox4 = New System.Windows.Forms.ComboBox
            Me.GroupBox10 = New System.Windows.Forms.GroupBox
            Me.Label3 = New System.Windows.Forms.Label
            Me.Label4 = New System.Windows.Forms.Label
            Me.Label5 = New System.Windows.Forms.Label
            Me.Label6 = New System.Windows.Forms.Label
            Me.Label7 = New System.Windows.Forms.Label
            Me.Label8 = New System.Windows.Forms.Label
            Me.Label9 = New System.Windows.Forms.Label
            Me.Label10 = New System.Windows.Forms.Label
            Me.Label11 = New System.Windows.Forms.Label
            Me.Label12 = New System.Windows.Forms.Label
            Me.Label13 = New System.Windows.Forms.Label
            Me.Label14 = New System.Windows.Forms.Label
            Me.Label15 = New System.Windows.Forms.Label
            Me.Label16 = New System.Windows.Forms.Label
            Me.GroupBox1.SuspendLayout()
            Me.GroupBox2.SuspendLayout()
            Me.GroupBox3.SuspendLayout()
            Me.GroupBox5.SuspendLayout()
            Me.GroupBox6.SuspendLayout()
            Me.GroupBox7.SuspendLayout()
            Me.GroupBox8.SuspendLayout()
            CType(Me.PictureBox1, System.ComponentModel.ISupportInitialize).BeginInit()
            Me.GroupBox9.SuspendLayout()
            CType(Me.PictureBox2, System.ComponentModel.ISupportInitialize).BeginInit()
            Me.GroupBox4.SuspendLayout()
            Me.GroupBox10.SuspendLayout()
            Me.SuspendLayout()
            '
            'Button1
            '
            Me.Button1.Location = New System.Drawing.Point(12, 1)
            Me.Button1.Name = "Button1"
            Me.Button1.Size = New System.Drawing.Size(132, 21)
            Me.Button1.TabIndex = 0
            Me.Button1.Text = "Open file"
            Me.Button1.UseVisualStyleBackColor = True
            '
            'OpenFileDialog1
            '
            Me.OpenFileDialog1.Filter = "All Supported Files|*.mp3;*.mp2;*.mp1;*.ogg;*.oga;*.flac;*.wav;*.ac3;*.aac|Mp3 Fi" & _
                "les|*.mp3|Mp2 Files|*.mp2|Mp1 Files|*.mp1|Ogg Files|*.ogg|FLAC files|*.flac|Wav " & _
                "files|*.wav|AC-3|*.ac3|AAC|*.aac"
            Me.OpenFileDialog1.Title = "Open song"
            '
            'Button2
            '
            Me.Button2.Location = New System.Drawing.Point(12, 127)
            Me.Button2.Name = "Button2"
            Me.Button2.Size = New System.Drawing.Size(63, 23)
            Me.Button2.TabIndex = 1
            Me.Button2.Text = "Play"
            Me.Button2.UseVisualStyleBackColor = True
            '
            'Button3
            '
            Me.Button3.Location = New System.Drawing.Point(81, 127)
            Me.Button3.Name = "Button3"
            Me.Button3.Size = New System.Drawing.Size(63, 23)
            Me.Button3.TabIndex = 2
            Me.Button3.Text = "Pause"
            Me.Button3.UseVisualStyleBackColor = True
            '
            'Button4
            '
            Me.Button4.Location = New System.Drawing.Point(150, 127)
            Me.Button4.Name = "Button4"
            Me.Button4.Size = New System.Drawing.Size(64, 23)
            Me.Button4.TabIndex = 3
            Me.Button4.Text = "Resume"
            Me.Button4.UseVisualStyleBackColor = True
            '
            'Button5
            '
            Me.Button5.Location = New System.Drawing.Point(220, 127)
            Me.Button5.Name = "Button5"
            Me.Button5.Size = New System.Drawing.Size(63, 23)
            Me.Button5.TabIndex = 4
            Me.Button5.Text = "Stop"
            Me.Button5.UseVisualStyleBackColor = True
            '
            'Button6
            '
            Me.Button6.Location = New System.Drawing.Point(12, 28)
            Me.Button6.Name = "Button6"
            Me.Button6.Size = New System.Drawing.Size(132, 21)
            Me.Button6.TabIndex = 5
            Me.Button6.Text = "Open static stream"
            Me.Button6.UseVisualStyleBackColor = True
            '
            'Button7
            '
            Me.Button7.Location = New System.Drawing.Point(152, 28)
            Me.Button7.Name = "Button7"
            Me.Button7.Size = New System.Drawing.Size(132, 20)
            Me.Button7.TabIndex = 6
            Me.Button7.Text = "Open dynamic stream"
            Me.Button7.UseVisualStyleBackColor = True
            '
            'GroupBox1
            '
            Me.GroupBox1.Controls.Add(Me.descr1)
            Me.GroupBox1.Controls.Add(Me.descr)
            Me.GroupBox1.Location = New System.Drawing.Point(290, 1)
            Me.GroupBox1.Name = "GroupBox1"
            Me.GroupBox1.Size = New System.Drawing.Size(296, 108)
            Me.GroupBox1.TabIndex = 7
            Me.GroupBox1.TabStop = False
            Me.GroupBox1.Text = "Info"
            '
            'descr1
            '
            Me.descr1.Location = New System.Drawing.Point(77, 15)
            Me.descr1.Name = "descr1"
            Me.descr1.Size = New System.Drawing.Size(208, 83)
            Me.descr1.TabIndex = 1
            '
            'descr
            '
            Me.descr.Location = New System.Drawing.Point(7, 16)
            Me.descr.Name = "descr"
            Me.descr.Size = New System.Drawing.Size(70, 83)
            Me.descr.TabIndex = 0
            '
            'Button8
            '
            Me.Button8.Location = New System.Drawing.Point(150, 179)
            Me.Button8.Name = "Button8"
            Me.Button8.Size = New System.Drawing.Size(63, 23)
            Me.Button8.TabIndex = 8
            Me.Button8.Text = "Vocal cut"
            Me.Button8.UseVisualStyleBackColor = True
            '
            'ProgressBar1
            '
            Me.ProgressBar1.Location = New System.Drawing.Point(12, 266)
            Me.ProgressBar1.Name = "ProgressBar1"
            Me.ProgressBar1.Size = New System.Drawing.Size(271, 23)
            Me.ProgressBar1.Step = 1
            Me.ProgressBar1.Style = System.Windows.Forms.ProgressBarStyle.Continuous
            Me.ProgressBar1.TabIndex = 9
            '
            'Timer1
            '
            Me.Timer1.Enabled = True
            Me.Timer1.Interval = 200
            '
            'Button9
            '
            Me.Button9.Location = New System.Drawing.Point(12, 153)
            Me.Button9.Name = "Button9"
            Me.Button9.Size = New System.Drawing.Size(63, 23)
            Me.Button9.TabIndex = 10
            Me.Button9.Text = "Jump rev"
            Me.Button9.UseVisualStyleBackColor = True
            '
            'Button10
            '
            Me.Button10.Location = New System.Drawing.Point(81, 153)
            Me.Button10.Name = "Button10"
            Me.Button10.Size = New System.Drawing.Size(63, 23)
            Me.Button10.TabIndex = 11
            Me.Button10.Text = "Jump fwd"
            Me.Button10.UseVisualStyleBackColor = True
            '
            'Button11
            '
            Me.Button11.Location = New System.Drawing.Point(150, 153)
            Me.Button11.Name = "Button11"
            Me.Button11.Size = New System.Drawing.Size(64, 23)
            Me.Button11.TabIndex = 12
            Me.Button11.Text = "Loop 2 sec"
            Me.Button11.UseVisualStyleBackColor = True
            '
            'Button12
            '
            Me.Button12.Location = New System.Drawing.Point(125, 237)
            Me.Button12.Name = "Button12"
            Me.Button12.Size = New System.Drawing.Size(132, 23)
            Me.Button12.TabIndex = 13
            Me.Button12.Text = "Reverse mode"
            Me.Button12.UseVisualStyleBackColor = True
            '
            'GroupBox2
            '
            Me.GroupBox2.Controls.Add(Me.position)
            Me.GroupBox2.Location = New System.Drawing.Point(12, 209)
            Me.GroupBox2.Name = "GroupBox2"
            Me.GroupBox2.Size = New System.Drawing.Size(107, 51)
            Me.GroupBox2.TabIndex = 14
            Me.GroupBox2.TabStop = False
            Me.GroupBox2.Text = "Position"
            '
            'position
            '
            Me.position.Location = New System.Drawing.Point(6, 16)
            Me.position.Name = "position"
            Me.position.Size = New System.Drawing.Size(91, 20)
            Me.position.TabIndex = 0
            '
            'GroupBox3
            '
            Me.GroupBox3.Controls.Add(Me.rightplayervolume)
            Me.GroupBox3.Controls.Add(Me.rightmastervolume)
            Me.GroupBox3.Controls.Add(Me.leftplayervolume)
            Me.GroupBox3.Controls.Add(Me.leftmastervolume)
            Me.GroupBox3.Location = New System.Drawing.Point(592, 1)
            Me.GroupBox3.Name = "GroupBox3"
            Me.GroupBox3.Size = New System.Drawing.Size(179, 141)
            Me.GroupBox3.TabIndex = 15
            Me.GroupBox3.TabStop = False
            Me.GroupBox3.Text = "Master - Player volume"
            '
            'rightplayervolume
            '
            Me.rightplayervolume.LargeChange = 1
            Me.rightplayervolume.Location = New System.Drawing.Point(142, 16)
            Me.rightplayervolume.Name = "rightplayervolume"
            Me.rightplayervolume.Size = New System.Drawing.Size(13, 115)
            Me.rightplayervolume.TabIndex = 1
            '
            'rightmastervolume
            '
            Me.rightmastervolume.LargeChange = 1
            Me.rightmastervolume.Location = New System.Drawing.Point(38, 15)
            Me.rightmastervolume.Name = "rightmastervolume"
            Me.rightmastervolume.Size = New System.Drawing.Size(13, 114)
            Me.rightmastervolume.TabIndex = 1
            '
            'leftplayervolume
            '
            Me.leftplayervolume.LargeChange = 1
            Me.leftplayervolume.Location = New System.Drawing.Point(116, 16)
            Me.leftplayervolume.Name = "leftplayervolume"
            Me.leftplayervolume.Size = New System.Drawing.Size(13, 115)
            Me.leftplayervolume.TabIndex = 0
            '
            'leftmastervolume
            '
            Me.leftmastervolume.LargeChange = 1
            Me.leftmastervolume.Location = New System.Drawing.Point(15, 16)
            Me.leftmastervolume.Name = "leftmastervolume"
            Me.leftmastervolume.Size = New System.Drawing.Size(13, 115)
            Me.leftmastervolume.TabIndex = 0
            '
            'GroupBox5
            '
            Me.GroupBox5.Controls.Add(Me.statusvalue2)
            Me.GroupBox5.Controls.Add(Me.statuslabel2)
            Me.GroupBox5.Controls.Add(Me.statusvalue1)
            Me.GroupBox5.Controls.Add(Me.statuslabel1)
            Me.GroupBox5.Location = New System.Drawing.Point(12, 295)
            Me.GroupBox5.Name = "GroupBox5"
            Me.GroupBox5.Size = New System.Drawing.Size(271, 117)
            Me.GroupBox5.TabIndex = 17
            Me.GroupBox5.TabStop = False
            Me.GroupBox5.Text = "Status"
            '
            'statusvalue2
            '
            Me.statusvalue2.Location = New System.Drawing.Point(229, 16)
            Me.statusvalue2.Name = "statusvalue2"
            Me.statusvalue2.Size = New System.Drawing.Size(36, 91)
            Me.statusvalue2.TabIndex = 3
            '
            'statuslabel2
            '
            Me.statuslabel2.Location = New System.Drawing.Point(125, 16)
            Me.statuslabel2.Name = "statuslabel2"
            Me.statuslabel2.Size = New System.Drawing.Size(98, 91)
            Me.statuslabel2.TabIndex = 2
            '
            'statusvalue1
            '
            Me.statusvalue1.Location = New System.Drawing.Point(82, 16)
            Me.statusvalue1.Name = "statusvalue1"
            Me.statusvalue1.Size = New System.Drawing.Size(37, 91)
            Me.statusvalue1.TabIndex = 1
            Me.statusvalue1.TextAlign = System.Drawing.ContentAlignment.TopRight
            '
            'statuslabel1
            '
            Me.statuslabel1.Location = New System.Drawing.Point(6, 16)
            Me.statuslabel1.Name = "statuslabel1"
            Me.statuslabel1.Size = New System.Drawing.Size(70, 91)
            Me.statuslabel1.TabIndex = 0
            '
            'leftvu
            '
            Me.leftvu.Location = New System.Drawing.Point(672, 217)
            Me.leftvu.Name = "leftvu"
            Me.leftvu.Size = New System.Drawing.Size(99, 25)
            Me.leftvu.Step = 1
            Me.leftvu.Style = System.Windows.Forms.ProgressBarStyle.Continuous
            Me.leftvu.TabIndex = 18
            '
            'rightvu
            '
            Me.rightvu.Location = New System.Drawing.Point(672, 256)
            Me.rightvu.Name = "rightvu"
            Me.rightvu.Size = New System.Drawing.Size(99, 23)
            Me.rightvu.Step = 1
            Me.rightvu.Style = System.Windows.Forms.ProgressBarStyle.Continuous
            Me.rightvu.TabIndex = 19
            '
            'Timer2
            '
            Me.Timer2.Enabled = True
            Me.Timer2.Interval = 50
            '
            'Button13
            '
            Me.Button13.Location = New System.Drawing.Point(12, 180)
            Me.Button13.Name = "Button13"
            Me.Button13.Size = New System.Drawing.Size(63, 23)
            Me.Button13.TabIndex = 20
            Me.Button13.Text = "Fade in"
            Me.Button13.UseVisualStyleBackColor = True
            '
            'Button14
            '
            Me.Button14.Location = New System.Drawing.Point(81, 180)
            Me.Button14.Name = "Button14"
            Me.Button14.Size = New System.Drawing.Size(63, 23)
            Me.Button14.TabIndex = 21
            Me.Button14.Text = "Fade out"
            Me.Button14.UseVisualStyleBackColor = True
            '
            'GroupBox6
            '
            Me.GroupBox6.Controls.Add(Me.VScrollBar11)
            Me.GroupBox6.Controls.Add(Me.VScrollBar10)
            Me.GroupBox6.Controls.Add(Me.VScrollBar9)
            Me.GroupBox6.Controls.Add(Me.VScrollBar8)
            Me.GroupBox6.Controls.Add(Me.VScrollBar7)
            Me.GroupBox6.Controls.Add(Me.VScrollBar6)
            Me.GroupBox6.Controls.Add(Me.VScrollBar5)
            Me.GroupBox6.Controls.Add(Me.VScrollBar4)
            Me.GroupBox6.Controls.Add(Me.VScrollBar3)
            Me.GroupBox6.Controls.Add(Me.VScrollBar2)
            Me.GroupBox6.Controls.Add(Me.VScrollBar1)
            Me.GroupBox6.Controls.Add(Me.CheckBox1)
            Me.GroupBox6.Location = New System.Drawing.Point(289, 269)
            Me.GroupBox6.Name = "GroupBox6"
            Me.GroupBox6.Size = New System.Drawing.Size(297, 143)
            Me.GroupBox6.TabIndex = 22
            Me.GroupBox6.TabStop = False
            Me.GroupBox6.Text = "Equalizer"
            '
            'VScrollBar11
            '
            Me.VScrollBar11.LargeChange = 1
            Me.VScrollBar11.Location = New System.Drawing.Point(270, 38)
            Me.VScrollBar11.Maximum = 40
            Me.VScrollBar11.Name = "VScrollBar11"
            Me.VScrollBar11.Size = New System.Drawing.Size(16, 95)
            Me.VScrollBar11.TabIndex = 11
            Me.VScrollBar11.Value = 20
            '
            'VScrollBar10
            '
            Me.VScrollBar10.LargeChange = 1
            Me.VScrollBar10.Location = New System.Drawing.Point(244, 38)
            Me.VScrollBar10.Maximum = 40
            Me.VScrollBar10.Name = "VScrollBar10"
            Me.VScrollBar10.Size = New System.Drawing.Size(16, 95)
            Me.VScrollBar10.TabIndex = 10
            Me.VScrollBar10.Value = 20
            '
            'VScrollBar9
            '
            Me.VScrollBar9.LargeChange = 1
            Me.VScrollBar9.Location = New System.Drawing.Point(218, 38)
            Me.VScrollBar9.Maximum = 40
            Me.VScrollBar9.Name = "VScrollBar9"
            Me.VScrollBar9.Size = New System.Drawing.Size(16, 95)
            Me.VScrollBar9.TabIndex = 9
            Me.VScrollBar9.Value = 20
            '
            'VScrollBar8
            '
            Me.VScrollBar8.LargeChange = 1
            Me.VScrollBar8.Location = New System.Drawing.Point(192, 38)
            Me.VScrollBar8.Maximum = 40
            Me.VScrollBar8.Name = "VScrollBar8"
            Me.VScrollBar8.Size = New System.Drawing.Size(16, 95)
            Me.VScrollBar8.TabIndex = 8
            Me.VScrollBar8.Value = 20
            '
            'VScrollBar7
            '
            Me.VScrollBar7.LargeChange = 1
            Me.VScrollBar7.Location = New System.Drawing.Point(166, 38)
            Me.VScrollBar7.Maximum = 40
            Me.VScrollBar7.Name = "VScrollBar7"
            Me.VScrollBar7.Size = New System.Drawing.Size(16, 95)
            Me.VScrollBar7.TabIndex = 7
            Me.VScrollBar7.Value = 20
            '
            'VScrollBar6
            '
            Me.VScrollBar6.LargeChange = 1
            Me.VScrollBar6.Location = New System.Drawing.Point(140, 38)
            Me.VScrollBar6.Maximum = 40
            Me.VScrollBar6.Name = "VScrollBar6"
            Me.VScrollBar6.Size = New System.Drawing.Size(16, 95)
            Me.VScrollBar6.TabIndex = 6
            Me.VScrollBar6.Value = 20
            '
            'VScrollBar5
            '
            Me.VScrollBar5.LargeChange = 1
            Me.VScrollBar5.Location = New System.Drawing.Point(114, 38)
            Me.VScrollBar5.Maximum = 40
            Me.VScrollBar5.Name = "VScrollBar5"
            Me.VScrollBar5.Size = New System.Drawing.Size(16, 95)
            Me.VScrollBar5.TabIndex = 5
            Me.VScrollBar5.Value = 20
            '
            'VScrollBar4
            '
            Me.VScrollBar4.LargeChange = 1
            Me.VScrollBar4.Location = New System.Drawing.Point(88, 38)
            Me.VScrollBar4.Maximum = 40
            Me.VScrollBar4.Name = "VScrollBar4"
            Me.VScrollBar4.Size = New System.Drawing.Size(16, 95)
            Me.VScrollBar4.TabIndex = 4
            Me.VScrollBar4.Value = 20
            '
            'VScrollBar3
            '
            Me.VScrollBar3.LargeChange = 1
            Me.VScrollBar3.Location = New System.Drawing.Point(62, 38)
            Me.VScrollBar3.Maximum = 40
            Me.VScrollBar3.Name = "VScrollBar3"
            Me.VScrollBar3.Size = New System.Drawing.Size(16, 95)
            Me.VScrollBar3.TabIndex = 3
            Me.VScrollBar3.Value = 20
            '
            'VScrollBar2
            '
            Me.VScrollBar2.LargeChange = 1
            Me.VScrollBar2.Location = New System.Drawing.Point(36, 38)
            Me.VScrollBar2.Maximum = 40
            Me.VScrollBar2.Name = "VScrollBar2"
            Me.VScrollBar2.Size = New System.Drawing.Size(16, 95)
            Me.VScrollBar2.TabIndex = 2
            Me.VScrollBar2.Value = 20
            '
            'VScrollBar1
            '
            Me.VScrollBar1.LargeChange = 1
            Me.VScrollBar1.Location = New System.Drawing.Point(9, 38)
            Me.VScrollBar1.Maximum = 40
            Me.VScrollBar1.Name = "VScrollBar1"
            Me.VScrollBar1.Size = New System.Drawing.Size(16, 95)
            Me.VScrollBar1.TabIndex = 1
            Me.VScrollBar1.Value = 20
            '
            'CheckBox1
            '
            Me.CheckBox1.AutoSize = True
            Me.CheckBox1.Location = New System.Drawing.Point(9, 19)
            Me.CheckBox1.Name = "CheckBox1"
            Me.CheckBox1.Size = New System.Drawing.Size(59, 17)
            Me.CheckBox1.TabIndex = 0
            Me.CheckBox1.Text = "Enable"
            Me.CheckBox1.UseVisualStyleBackColor = True
            '
            'Button15
            '
            Me.Button15.Location = New System.Drawing.Point(220, 153)
            Me.Button15.Name = "Button15"
            Me.Button15.Size = New System.Drawing.Size(64, 23)
            Me.Button15.TabIndex = 23
            Me.Button15.Text = "Echo"
            Me.Button15.UseVisualStyleBackColor = True
            '
            'GroupBox7
            '
            Me.GroupBox7.Controls.Add(Me.VScrollBar14)
            Me.GroupBox7.Controls.Add(Me.VScrollBar13)
            Me.GroupBox7.Controls.Add(Me.VScrollBar12)
            Me.GroupBox7.Location = New System.Drawing.Point(592, 148)
            Me.GroupBox7.Name = "GroupBox7"
            Me.GroupBox7.Size = New System.Drawing.Size(74, 141)
            Me.GroupBox7.TabIndex = 24
            Me.GroupBox7.TabStop = False
            Me.GroupBox7.Text = "PTR"
            '
            'VScrollBar14
            '
            Me.VScrollBar14.LargeChange = 1
            Me.VScrollBar14.Location = New System.Drawing.Point(49, 16)
            Me.VScrollBar14.Maximum = 200
            Me.VScrollBar14.Name = "VScrollBar14"
            Me.VScrollBar14.Size = New System.Drawing.Size(13, 115)
            Me.VScrollBar14.TabIndex = 2
            Me.VScrollBar14.Value = 100
            '
            'VScrollBar13
            '
            Me.VScrollBar13.LargeChange = 1
            Me.VScrollBar13.Location = New System.Drawing.Point(26, 16)
            Me.VScrollBar13.Maximum = 200
            Me.VScrollBar13.Name = "VScrollBar13"
            Me.VScrollBar13.Size = New System.Drawing.Size(13, 115)
            Me.VScrollBar13.TabIndex = 1
            Me.VScrollBar13.Value = 100
            '
            'VScrollBar12
            '
            Me.VScrollBar12.LargeChange = 1
            Me.VScrollBar12.Location = New System.Drawing.Point(3, 16)
            Me.VScrollBar12.Maximum = 200
            Me.VScrollBar12.Name = "VScrollBar12"
            Me.VScrollBar12.Size = New System.Drawing.Size(13, 115)
            Me.VScrollBar12.TabIndex = 0
            Me.VScrollBar12.Value = 100
            '
            'Button16
            '
            Me.Button16.Location = New System.Drawing.Point(220, 180)
            Me.Button16.Name = "Button16"
            Me.Button16.Size = New System.Drawing.Size(63, 23)
            Me.Button16.TabIndex = 25
            Me.Button16.Text = "Side cut"
            Me.Button16.UseVisualStyleBackColor = True
            '
            'GroupBox8
            '
            Me.GroupBox8.Controls.Add(Me.CheckBox3)
            Me.GroupBox8.Controls.Add(Me.CheckBox2)
            Me.GroupBox8.Controls.Add(Me.ComboBox3)
            Me.GroupBox8.Controls.Add(Me.ComboBox2)
            Me.GroupBox8.Controls.Add(Me.FFTLinear)
            Me.GroupBox8.Controls.Add(Me.ComboBox1)
            Me.GroupBox8.Controls.Add(Me.FFTEnabled)
            Me.GroupBox8.Controls.Add(Me.PictureBox1)
            Me.GroupBox8.Location = New System.Drawing.Point(8, 418)
            Me.GroupBox8.Name = "GroupBox8"
            Me.GroupBox8.Size = New System.Drawing.Size(578, 152)
            Me.GroupBox8.TabIndex = 27
            Me.GroupBox8.TabStop = False
            Me.GroupBox8.Text = "FFT"
            '
            'CheckBox3
            '
            Me.CheckBox3.AutoSize = True
            Me.CheckBox3.Checked = True
            Me.CheckBox3.CheckState = System.Windows.Forms.CheckState.Checked
            Me.CheckBox3.Location = New System.Drawing.Point(146, 128)
            Me.CheckBox3.Name = "CheckBox3"
            Me.CheckBox3.Size = New System.Drawing.Size(53, 17)
            Me.CheckBox3.TabIndex = 7
            Me.CheckBox3.Text = "Scale"
            Me.CheckBox3.UseVisualStyleBackColor = True
            '
            'CheckBox2
            '
            Me.CheckBox2.AutoSize = True
            Me.CheckBox2.Checked = True
            Me.CheckBox2.CheckState = System.Windows.Forms.CheckState.Checked
            Me.CheckBox2.Location = New System.Drawing.Point(213, 128)
            Me.CheckBox2.Name = "CheckBox2"
            Me.CheckBox2.Size = New System.Drawing.Size(45, 17)
            Me.CheckBox2.TabIndex = 6
            Me.CheckBox2.Text = "Grid"
            Me.CheckBox2.UseVisualStyleBackColor = True
            '
            'ComboBox3
            '
            Me.ComboBox3.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
            Me.ComboBox3.FormattingEnabled = True
            Me.ComboBox3.Items.AddRange(New Object() {"Rectangular", "Hamming", "Hann", "Cosine", "Lanczos", "Bartlett", "Triangular", "Gauss", "Bartlett-Hann", "Blackman", "Nuttall", "Blackman-Harris", "Blackman-Nuttall", "Flat-Top"})
            Me.ComboBox3.Location = New System.Drawing.Point(406, 128)
            Me.ComboBox3.Name = "ComboBox3"
            Me.ComboBox3.Size = New System.Drawing.Size(103, 21)
            Me.ComboBox3.TabIndex = 5
            '
            'ComboBox2
            '
            Me.ComboBox2.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
            Me.ComboBox2.FormattingEnabled = True
            Me.ComboBox2.Items.AddRange(New Object() {"4", "8", "16", "32", "64", "128", "256", "512", "1204", "2048", "4096"})
            Me.ComboBox2.Location = New System.Drawing.Point(515, 128)
            Me.ComboBox2.Name = "ComboBox2"
            Me.ComboBox2.Size = New System.Drawing.Size(53, 21)
            Me.ComboBox2.TabIndex = 4
            '
            'FFTLinear
            '
            Me.FFTLinear.AutoSize = True
            Me.FFTLinear.Location = New System.Drawing.Point(77, 128)
            Me.FFTLinear.Name = "FFTLinear"
            Me.FFTLinear.Size = New System.Drawing.Size(55, 17)
            Me.FFTLinear.TabIndex = 3
            Me.FFTLinear.Text = "Linear"
            Me.FFTLinear.UseVisualStyleBackColor = True
            '
            'ComboBox1
            '
            Me.ComboBox1.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
            Me.ComboBox1.FormattingEnabled = True
            Me.ComboBox1.Items.AddRange(New Object() {"Lines (Left On Top)", "Lines (Right On Top)", "Area (Left On Top)", "Area (Right On Top)", "Bars (Left On Top)", "Bars (Right OnTop)", "Spectrum"})
            Me.ComboBox1.Location = New System.Drawing.Point(281, 128)
            Me.ComboBox1.Name = "ComboBox1"
            Me.ComboBox1.Size = New System.Drawing.Size(119, 21)
            Me.ComboBox1.TabIndex = 2
            '
            'FFTEnabled
            '
            Me.FFTEnabled.AutoSize = True
            Me.FFTEnabled.Checked = True
            Me.FFTEnabled.CheckState = System.Windows.Forms.CheckState.Checked
            Me.FFTEnabled.Location = New System.Drawing.Point(4, 128)
            Me.FFTEnabled.Name = "FFTEnabled"
            Me.FFTEnabled.Size = New System.Drawing.Size(59, 17)
            Me.FFTEnabled.TabIndex = 1
            Me.FFTEnabled.Text = "Enable"
            Me.FFTEnabled.UseVisualStyleBackColor = True
            '
            'PictureBox1
            '
            Me.PictureBox1.BackColor = System.Drawing.Color.Black
            Me.PictureBox1.Location = New System.Drawing.Point(4, 10)
            Me.PictureBox1.Name = "PictureBox1"
            Me.PictureBox1.Size = New System.Drawing.Size(554, 114)
            Me.PictureBox1.TabIndex = 0
            Me.PictureBox1.TabStop = False
            '
            'GroupBox9
            '
            Me.GroupBox9.Controls.Add(Me.Label16)
            Me.GroupBox9.Controls.Add(Me.Label15)
            Me.GroupBox9.Controls.Add(Me.Label14)
            Me.GroupBox9.Controls.Add(Me.Label13)
            Me.GroupBox9.Controls.Add(Me.Label12)
            Me.GroupBox9.Controls.Add(Me.Label11)
            Me.GroupBox9.Controls.Add(Me.Label10)
            Me.GroupBox9.Controls.Add(Me.Label9)
            Me.GroupBox9.Controls.Add(Me.Label8)
            Me.GroupBox9.Controls.Add(Me.Label7)
            Me.GroupBox9.Controls.Add(Me.Label6)
            Me.GroupBox9.Controls.Add(Me.Label5)
            Me.GroupBox9.Controls.Add(Me.Label4)
            Me.GroupBox9.Controls.Add(Me.Label3)
            Me.GroupBox9.Location = New System.Drawing.Point(289, 115)
            Me.GroupBox9.Name = "GroupBox9"
            Me.GroupBox9.Size = New System.Drawing.Size(296, 145)
            Me.GroupBox9.TabIndex = 28
            Me.GroupBox9.TabStop = False
            Me.GroupBox9.Text = "ID3"
            '
            'Button17
            '
            Me.Button17.Location = New System.Drawing.Point(125, 208)
            Me.Button17.Name = "Button17"
            Me.Button17.Size = New System.Drawing.Size(132, 23)
            Me.Button17.TabIndex = 29
            Me.Button17.Text = "Detect BPM"
            Me.Button17.UseVisualStyleBackColor = True
            '
            'callback_text
            '
            Me.callback_text.Location = New System.Drawing.Point(673, 148)
            Me.callback_text.Name = "callback_text"
            Me.callback_text.Size = New System.Drawing.Size(98, 53)
            Me.callback_text.TabIndex = 30
            '
            'Button18
            '
            Me.Button18.Location = New System.Drawing.Point(152, 1)
            Me.Button18.Name = "Button18"
            Me.Button18.Size = New System.Drawing.Size(132, 21)
            Me.Button18.TabIndex = 31
            Me.Button18.Text = "Add file"
            Me.Button18.UseVisualStyleBackColor = True
            '
            'PictureBox2
            '
            Me.PictureBox2.Location = New System.Drawing.Point(3, 16)
            Me.PictureBox2.Name = "PictureBox2"
            Me.PictureBox2.Size = New System.Drawing.Size(182, 256)
            Me.PictureBox2.TabIndex = 32
            Me.PictureBox2.TabStop = False
            '
            'SaveFileDialog1
            '
            Me.SaveFileDialog1.Filter = "Wave File|*.wav"
            Me.SaveFileDialog1.Title = "Save to wave file"
            '
            'GroupBox4
            '
            Me.GroupBox4.Controls.Add(Me.Button20)
            Me.GroupBox4.Controls.Add(Me.CheckBox4)
            Me.GroupBox4.Controls.Add(Me.Label2)
            Me.GroupBox4.Controls.Add(Me.Label1)
            Me.GroupBox4.Controls.Add(Me.ComboBox5)
            Me.GroupBox4.Controls.Add(Me.ComboBox4)
            Me.GroupBox4.Location = New System.Drawing.Point(12, 55)
            Me.GroupBox4.Name = "GroupBox4"
            Me.GroupBox4.Size = New System.Drawing.Size(265, 66)
            Me.GroupBox4.TabIndex = 34
            Me.GroupBox4.TabStop = False
            Me.GroupBox4.Text = "Recording"
            '
            'Button20
            '
            Me.Button20.Location = New System.Drawing.Point(10, 42)
            Me.Button20.Name = "Button20"
            Me.Button20.Size = New System.Drawing.Size(118, 21)
            Me.Button20.TabIndex = 8
            Me.Button20.Text = "Record"
            Me.Button20.UseVisualStyleBackColor = True
            '
            'CheckBox4
            '
            Me.CheckBox4.AutoSize = True
            Me.CheckBox4.Location = New System.Drawing.Point(149, 44)
            Me.CheckBox4.Name = "CheckBox4"
            Me.CheckBox4.Size = New System.Drawing.Size(111, 17)
            Me.CheckBox4.TabIndex = 7
            Me.CheckBox4.Text = "Play to soundcard"
            Me.CheckBox4.UseVisualStyleBackColor = True
            '
            'Label2
            '
            Me.Label2.AutoSize = True
            Me.Label2.Location = New System.Drawing.Point(133, 22)
            Me.Label2.Name = "Label2"
            Me.Label2.Size = New System.Drawing.Size(32, 13)
            Me.Label2.TabIndex = 6
            Me.Label2.Text = "Dest:"
            '
            'Label1
            '
            Me.Label1.AutoSize = True
            Me.Label1.Location = New System.Drawing.Point(4, 22)
            Me.Label1.Name = "Label1"
            Me.Label1.Size = New System.Drawing.Size(26, 13)
            Me.Label1.TabIndex = 5
            Me.Label1.Text = "Src:"
            '
            'ComboBox5
            '
            Me.ComboBox5.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
            Me.ComboBox5.FormattingEnabled = True
            Me.ComboBox5.Items.AddRange(New Object() {"Soundcard", "Mp3 File", "Ogg File", "FLAC File", "Flac Ogg File", "AAC file", "Wav File", "PCM File"})
            Me.ComboBox5.Location = New System.Drawing.Point(171, 19)
            Me.ComboBox5.Name = "ComboBox5"
            Me.ComboBox5.Size = New System.Drawing.Size(88, 21)
            Me.ComboBox5.TabIndex = 4
            '
            'ComboBox4
            '
            Me.ComboBox4.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
            Me.ComboBox4.FormattingEnabled = True
            Me.ComboBox4.Items.AddRange(New Object() {"Line In", "Microphone", "CD Audio", "Midi"})
            Me.ComboBox4.Location = New System.Drawing.Point(36, 19)
            Me.ComboBox4.Name = "ComboBox4"
            Me.ComboBox4.Size = New System.Drawing.Size(88, 21)
            Me.ComboBox4.TabIndex = 3
            '
            'GroupBox10
            '
            Me.GroupBox10.Controls.Add(Me.PictureBox2)
            Me.GroupBox10.Location = New System.Drawing.Point(592, 295)
            Me.GroupBox10.Name = "GroupBox10"
            Me.GroupBox10.Size = New System.Drawing.Size(191, 275)
            Me.GroupBox10.TabIndex = 35
            Me.GroupBox10.TabStop = False
            Me.GroupBox10.Text = "ID3 embeded picture"
            '
            'Label3
            '
            Me.Label3.Location = New System.Drawing.Point(62, 12)
            Me.Label3.Name = "Label3"
            Me.Label3.Size = New System.Drawing.Size(225, 16)
            Me.Label3.TabIndex = 1
            '
            'Label4
            '
            Me.Label4.Location = New System.Drawing.Point(62, 31)
            Me.Label4.Name = "Label4"
            Me.Label4.Size = New System.Drawing.Size(225, 16)
            Me.Label4.TabIndex = 2
            '
            'Label5
            '
            Me.Label5.Location = New System.Drawing.Point(62, 50)
            Me.Label5.Name = "Label5"
            Me.Label5.Size = New System.Drawing.Size(225, 16)
            Me.Label5.TabIndex = 3
            '
            'Label6
            '
            Me.Label6.Location = New System.Drawing.Point(62, 69)
            Me.Label6.Name = "Label6"
            Me.Label6.Size = New System.Drawing.Size(225, 16)
            Me.Label6.TabIndex = 4
            '
            'Label7
            '
            Me.Label7.Location = New System.Drawing.Point(62, 88)
            Me.Label7.Name = "Label7"
            Me.Label7.Size = New System.Drawing.Size(225, 16)
            Me.Label7.TabIndex = 5
            '
            'Label8
            '
            Me.Label8.Location = New System.Drawing.Point(62, 107)
            Me.Label8.Name = "Label8"
            Me.Label8.Size = New System.Drawing.Size(225, 16)
            Me.Label8.TabIndex = 6
            '
            'Label9
            '
            Me.Label9.Location = New System.Drawing.Point(62, 126)
            Me.Label9.Name = "Label9"
            Me.Label9.Size = New System.Drawing.Size(225, 16)
            Me.Label9.TabIndex = 7
            '
            'Label10
            '
            Me.Label10.AutoSize = True
            Me.Label10.Location = New System.Drawing.Point(6, 12)
            Me.Label10.Name = "Label10"
            Me.Label10.Size = New System.Drawing.Size(30, 13)
            Me.Label10.TabIndex = 8
            Me.Label10.Text = "Title:"
            '
            'Label11
            '
            Me.Label11.AutoSize = True
            Me.Label11.Location = New System.Drawing.Point(6, 31)
            Me.Label11.Name = "Label11"
            Me.Label11.Size = New System.Drawing.Size(33, 13)
            Me.Label11.TabIndex = 9
            Me.Label11.Text = "Artist:"
            '
            'Label12
            '
            Me.Label12.AutoSize = True
            Me.Label12.Location = New System.Drawing.Point(6, 50)
            Me.Label12.Name = "Label12"
            Me.Label12.Size = New System.Drawing.Size(39, 13)
            Me.Label12.TabIndex = 10
            Me.Label12.Text = "Album:"
            '
            'Label13
            '
            Me.Label13.AutoSize = True
            Me.Label13.Location = New System.Drawing.Point(6, 69)
            Me.Label13.Name = "Label13"
            Me.Label13.Size = New System.Drawing.Size(32, 13)
            Me.Label13.TabIndex = 11
            Me.Label13.Text = "Year:"
            '
            'Label14
            '
            Me.Label14.AutoSize = True
            Me.Label14.Location = New System.Drawing.Point(6, 88)
            Me.Label14.Name = "Label14"
            Me.Label14.Size = New System.Drawing.Size(38, 13)
            Me.Label14.TabIndex = 12
            Me.Label14.Text = "Track:"
            '
            'Label15
            '
            Me.Label15.AutoSize = True
            Me.Label15.Location = New System.Drawing.Point(6, 107)
            Me.Label15.Name = "Label15"
            Me.Label15.Size = New System.Drawing.Size(50, 13)
            Me.Label15.TabIndex = 13
            Me.Label15.Text = "Encoder:"
            '
            'Label16
            '
            Me.Label16.AutoSize = True
            Me.Label16.Location = New System.Drawing.Point(6, 126)
            Me.Label16.Name = "Label16"
            Me.Label16.Size = New System.Drawing.Size(54, 13)
            Me.Label16.TabIndex = 14
            Me.Label16.Text = "Comment:"
            '
            'Form1
            '
            Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
            Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
            Me.ClientSize = New System.Drawing.Size(782, 569)
            Me.Controls.Add(Me.GroupBox10)
            Me.Controls.Add(Me.GroupBox4)
            Me.Controls.Add(Me.Button18)
            Me.Controls.Add(Me.callback_text)
            Me.Controls.Add(Me.Button17)
            Me.Controls.Add(Me.GroupBox9)
            Me.Controls.Add(Me.GroupBox8)
            Me.Controls.Add(Me.Button16)
            Me.Controls.Add(Me.GroupBox7)
            Me.Controls.Add(Me.Button15)
            Me.Controls.Add(Me.GroupBox6)
            Me.Controls.Add(Me.Button14)
            Me.Controls.Add(Me.Button13)
            Me.Controls.Add(Me.rightvu)
            Me.Controls.Add(Me.leftvu)
            Me.Controls.Add(Me.GroupBox5)
            Me.Controls.Add(Me.GroupBox3)
            Me.Controls.Add(Me.GroupBox2)
            Me.Controls.Add(Me.Button12)
            Me.Controls.Add(Me.Button11)
            Me.Controls.Add(Me.Button10)
            Me.Controls.Add(Me.Button9)
            Me.Controls.Add(Me.ProgressBar1)
            Me.Controls.Add(Me.Button8)
            Me.Controls.Add(Me.GroupBox1)
            Me.Controls.Add(Me.Button7)
            Me.Controls.Add(Me.Button6)
            Me.Controls.Add(Me.Button5)
            Me.Controls.Add(Me.Button4)
            Me.Controls.Add(Me.Button3)
            Me.Controls.Add(Me.Button2)
            Me.Controls.Add(Me.Button1)
            Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog
            Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
            Me.MaximizeBox = False
            Me.Name = "Form1"
            Me.Text = "libZPlay player"
            Me.GroupBox1.ResumeLayout(False)
            Me.GroupBox2.ResumeLayout(False)
            Me.GroupBox3.ResumeLayout(False)
            Me.GroupBox5.ResumeLayout(False)
            Me.GroupBox6.ResumeLayout(False)
            Me.GroupBox6.PerformLayout()
            Me.GroupBox7.ResumeLayout(False)
            Me.GroupBox8.ResumeLayout(False)
            Me.GroupBox8.PerformLayout()
            CType(Me.PictureBox1, System.ComponentModel.ISupportInitialize).EndInit()
            Me.GroupBox9.ResumeLayout(False)
            Me.GroupBox9.PerformLayout()
            CType(Me.PictureBox2, System.ComponentModel.ISupportInitialize).EndInit()
            Me.GroupBox4.ResumeLayout(False)
            Me.GroupBox4.PerformLayout()
            Me.GroupBox10.ResumeLayout(False)
            Me.ResumeLayout(False)

        End Sub
        Friend WithEvents Button1 As System.Windows.Forms.Button
        Friend WithEvents OpenFileDialog1 As System.Windows.Forms.OpenFileDialog
        Friend WithEvents Button2 As System.Windows.Forms.Button
        Friend WithEvents Button3 As System.Windows.Forms.Button
        Friend WithEvents Button4 As System.Windows.Forms.Button
        Friend WithEvents Button5 As System.Windows.Forms.Button
        Friend WithEvents Button6 As System.Windows.Forms.Button
        Friend WithEvents Button7 As System.Windows.Forms.Button
        Friend GroupBox1 As System.Windows.Forms.GroupBox
        Friend WithEvents Button8 As System.Windows.Forms.Button
        Friend WithEvents ProgressBar1 As System.Windows.Forms.ProgressBar
        Friend WithEvents Timer1 As System.Windows.Forms.Timer
        Friend WithEvents Button9 As System.Windows.Forms.Button
        Friend WithEvents Button10 As System.Windows.Forms.Button
        Friend WithEvents Button11 As System.Windows.Forms.Button
        Friend WithEvents Button12 As System.Windows.Forms.Button
        Friend GroupBox2 As System.Windows.Forms.GroupBox
        Friend position As System.Windows.Forms.Label
        Friend GroupBox3 As System.Windows.Forms.GroupBox
        Friend WithEvents rightmastervolume As System.Windows.Forms.VScrollBar
        Friend WithEvents leftmastervolume As System.Windows.Forms.VScrollBar
        Friend WithEvents rightplayervolume As System.Windows.Forms.VScrollBar
        Friend WithEvents leftplayervolume As System.Windows.Forms.VScrollBar
        Friend GroupBox5 As System.Windows.Forms.GroupBox
        Friend statuslabel1 As System.Windows.Forms.Label
        Friend statusvalue1 As System.Windows.Forms.Label
        Friend statuslabel2 As System.Windows.Forms.Label
        Friend statusvalue2 As System.Windows.Forms.Label
        Friend leftvu As System.Windows.Forms.ProgressBar
        Friend rightvu As System.Windows.Forms.ProgressBar
        Friend WithEvents Timer2 As System.Windows.Forms.Timer
        Friend WithEvents Button13 As System.Windows.Forms.Button
        Friend WithEvents Button14 As System.Windows.Forms.Button
        Friend GroupBox6 As System.Windows.Forms.GroupBox
        Friend WithEvents CheckBox1 As System.Windows.Forms.CheckBox
        Friend WithEvents VScrollBar1 As System.Windows.Forms.VScrollBar
        Friend WithEvents VScrollBar11 As System.Windows.Forms.VScrollBar
        Friend WithEvents VScrollBar10 As System.Windows.Forms.VScrollBar
        Friend WithEvents VScrollBar9 As System.Windows.Forms.VScrollBar
        Friend WithEvents VScrollBar8 As System.Windows.Forms.VScrollBar
        Friend WithEvents VScrollBar7 As System.Windows.Forms.VScrollBar
        Friend WithEvents VScrollBar6 As System.Windows.Forms.VScrollBar
        Friend WithEvents VScrollBar5 As System.Windows.Forms.VScrollBar
        Friend WithEvents VScrollBar4 As System.Windows.Forms.VScrollBar
        Friend WithEvents VScrollBar3 As System.Windows.Forms.VScrollBar
        Friend WithEvents VScrollBar2 As System.Windows.Forms.VScrollBar
        Friend WithEvents Button15 As System.Windows.Forms.Button
        Friend GroupBox7 As System.Windows.Forms.GroupBox
        Friend WithEvents VScrollBar14 As System.Windows.Forms.VScrollBar
        Friend WithEvents VScrollBar13 As System.Windows.Forms.VScrollBar
        Friend WithEvents VScrollBar12 As System.Windows.Forms.VScrollBar
        Friend WithEvents Button16 As System.Windows.Forms.Button
        Friend GroupBox8 As System.Windows.Forms.GroupBox
        Friend WithEvents PictureBox1 As System.Windows.Forms.PictureBox
        Friend FFTEnabled As System.Windows.Forms.CheckBox
        Friend WithEvents ComboBox1 As System.Windows.Forms.ComboBox
        Friend WithEvents FFTLinear As System.Windows.Forms.CheckBox
        Friend GroupBox9 As System.Windows.Forms.GroupBox
        Friend WithEvents ComboBox2 As System.Windows.Forms.ComboBox
        Friend WithEvents ComboBox3 As System.Windows.Forms.ComboBox
        Friend WithEvents CheckBox2 As System.Windows.Forms.CheckBox
        Friend WithEvents Button17 As System.Windows.Forms.Button
        Friend descr As System.Windows.Forms.Label
        Friend descr1 As System.Windows.Forms.Label
        Friend callback_text As System.Windows.Forms.Label
        Friend WithEvents Button18 As System.Windows.Forms.Button
        Friend WithEvents CheckBox3 As System.Windows.Forms.CheckBox
        Friend WithEvents PictureBox2 As System.Windows.Forms.PictureBox
        Friend WithEvents SaveFileDialog1 As System.Windows.Forms.SaveFileDialog
        Friend WithEvents GroupBox4 As System.Windows.Forms.GroupBox
        Friend WithEvents ComboBox4 As System.Windows.Forms.ComboBox
        Friend WithEvents ComboBox5 As System.Windows.Forms.ComboBox
        Friend WithEvents Button20 As System.Windows.Forms.Button
        Friend WithEvents CheckBox4 As System.Windows.Forms.CheckBox
        Friend WithEvents Label2 As System.Windows.Forms.Label
        Friend WithEvents Label1 As System.Windows.Forms.Label
        Friend WithEvents GroupBox10 As System.Windows.Forms.GroupBox
        Friend WithEvents Label9 As System.Windows.Forms.Label
        Friend WithEvents Label8 As System.Windows.Forms.Label
        Friend WithEvents Label7 As System.Windows.Forms.Label
        Friend WithEvents Label6 As System.Windows.Forms.Label
        Friend WithEvents Label5 As System.Windows.Forms.Label
        Friend WithEvents Label4 As System.Windows.Forms.Label
        Friend WithEvents Label3 As System.Windows.Forms.Label
        Friend WithEvents Label16 As System.Windows.Forms.Label
        Friend WithEvents Label15 As System.Windows.Forms.Label
        Friend WithEvents Label14 As System.Windows.Forms.Label
        Friend WithEvents Label13 As System.Windows.Forms.Label
        Friend WithEvents Label12 As System.Windows.Forms.Label
        Friend WithEvents Label11 As System.Windows.Forms.Label
        Friend WithEvents Label10 As System.Windows.Forms.Label

    End Class

End Namespace 'end of root namespace