#pragma once

#include "../../libzplaynet.h"
namespace libwmp3xplayer {

	using namespace System;
	using namespace System::ComponentModel;
	using namespace System::Collections;
	using namespace System::Windows::Forms;
	using namespace System::Data;
	using namespace System::Drawing;
	using namespace System::IO;

	using namespace libZPlay;

	/// <summary>
	/// Summary for Form1
	///
	/// WARNING: If you change the name of this class, you will need to change the
	///          'Resource File Name' property for the managed resource compiler tool
	///          associated with all .resx files this class depends on.  Otherwise,
	///          the designers will not be able to interact properly with localized
	///          resources associated with this form.
	/// </summary>
	public ref class Form1 : public System::Windows::Forms::Form
	{


	public:
		delegate void SetTextCallback(System::String ^text);


		static String ^s = "";

		void showinfo()
		{
			
			 Label3->Text = "";
            Label4->Text = "";
            Label5->Text = "";
            Label6->Text = "";
            Label7->Text = "";
            Label8->Text = "";
            Label9->Text = "";
		
			TID3InfoEx info = TID3InfoEx();
			if (player->LoadID3Ex(info, true))
			{
				Label3->Text = info.Title;
                Label4->Text = info.Artist;
                Label5->Text = info.Album;
                Label6->Text = info.Year;
                Label7->Text = info.Track;
                Label8->Text = info.Encoder;
                Label9->Text = info.Comment;
			}


			descr->Text = "Format:" + System::Environment::NewLine + "Length:" + System::Environment::NewLine + "Samplerate:" + System::Environment::NewLine + "Bitrate:" + System::Environment::NewLine + "Channel:" + System::Environment::NewLine + "VBR:";

			TStreamInfo StreamInfo;
			player->GetStreamInfo(StreamInfo);
			descr1->Text = StreamInfo.Description + System::Environment::NewLine + System::Convert::ToString(StreamInfo.Length.hms.hour) + " : " + System::Convert::ToString(StreamInfo.Length.hms.minute) + " : " + System::Convert::ToString(StreamInfo.Length.hms.second) + System::Environment::NewLine + System::Convert::ToString(StreamInfo.SamplingRate) + " Hz" + System::Environment::NewLine + System::Convert::ToString(StreamInfo.Bitrate) + " kbps" + System::Environment::NewLine + System::Convert::ToString(StreamInfo.ChannelNumber) + System::Environment::NewLine + System::Convert::ToString(StreamInfo.VBR);

			if(info.Picture.PicturePresent)
				pictureBox2->Image = info.Picture .Bitmap;

			ProgressBar1->Minimum = 0;
			ProgressBar1->Maximum = System::Convert::ToInt32(safe_cast<int>(StreamInfo.Length.sec));
			ProgressBar1->Value = 0;
			player->StartPlayback();
			Timer1->Enabled = true;
			Timer2->Enabled = true;
		}


		/// <summary>
		/// Callback function
		/// </summary>
		/// <param name="objptr"></param>
		/// <param name="user_data"></param>
		/// <param name="msg"></param>
		/// <param name="param1"></param>
		/// <param name="param2"></param>
		/// <returns></returns>
		/// <remarks></remarks>
		int MyCallbackFunc(System::UInt32 objptr, int user_data, TCallbackMessage msg, System::UInt32 param1, System::UInt32 param2)
		{


			switch (msg)
			{
				case TCallbackMessage::MsgEnterVolumeSlideAsync:
					SetText("EnterFadeAsync");

					break;
				case TCallbackMessage::MsgExitVolumeSlideAsync:
					SetText("ExitFadeAsync");
					FadeFinished = true;

					break;
				case TCallbackMessage::MsgStreamBufferDoneAsync:
				{
					BufferCounter = BufferCounter + 1;
					SetText("StreamBufferDoneAsync: " + System::Convert::ToString(BufferCounter));
					// read more data and push into stream
					array<System::Byte> ^stream_data = nullptr;
					int small_chunk = 100000;
					stream_data = br->ReadBytes(small_chunk);
					if (stream_data->Length > 0)
					{
						player->PushDataToStream(stream_data, System::Convert::ToUInt32(stream_data->Length));
					}
					else
					{
						array<System::Byte> ^tempMemNewData1 = nullptr;
						player->PushDataToStream(tempMemNewData1, 0);
					}
				}
				break;

				case TCallbackMessage::MsgNextSong:
				{
					SetText("StreamBufferDoneAsync: " + System::Convert::ToString(param1));
					NextSong = true;

				}
				break;
			}

			return 0;
		}

		

		Form1(void)
		{
			InitializeComponent();
			//
			//TODO: Add the constructor code here
			//
			player = gcnew ZPlay();
			LoadMode = false;
			FadeFinished = false;
			SideCut = false;
			VocalCut = false;
			ReverseMode = false;
			NextSong = false;

			// need this for managed stream
			fStream = nullptr;
			br = nullptr;
			BufferCounter = 0;

		}

	protected:
		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		~Form1()
		{
			if (components)
			{
				delete components;
				
			}

			delete player;

		}
	private: System::Windows::Forms::OpenFileDialog^  OpenFileDialog1;


			 // need this for managed stream
		System::IO::FileStream ^fStream ;
		System::IO::BinaryReader ^br;
		int BufferCounter;

private: System::Windows::Forms::Label^  callback_text;
internal: System::Windows::Forms::Button^  button16;
private: 
internal: System::Windows::Forms::Button^  button17;
private: System::Windows::Forms::Button^  button18;
private: System::Windows::Forms::CheckBox^  checkBox2;
private: System::Windows::Forms::PictureBox^  pictureBox2;




private: System::Windows::Forms::SaveFileDialog^  saveFileDialog1;
internal: System::Windows::Forms::GroupBox^  groupBox10;
private: 
internal: System::Windows::Forms::Button^  Button20;
internal: System::Windows::Forms::CheckBox^  CheckBox3;

internal: System::Windows::Forms::Label^  Label2;
internal: System::Windows::Forms::Label^  Label1;
internal: System::Windows::Forms::ComboBox^  ComboBox5;
internal: System::Windows::Forms::ComboBox^  ComboBox4;
private: System::Windows::Forms::GroupBox^  groupBox5;
internal: System::Windows::Forms::GroupBox^  groupBox1;
private: 
internal: System::Windows::Forms::Label^  Label16;
internal: System::Windows::Forms::Label^  Label15;
internal: System::Windows::Forms::Label^  Label14;
internal: System::Windows::Forms::Label^  Label13;
internal: System::Windows::Forms::Label^  Label12;
internal: System::Windows::Forms::Label^  Label11;
internal: System::Windows::Forms::Label^  Label10;
internal: System::Windows::Forms::Label^  Label9;
internal: System::Windows::Forms::Label^  Label8;
internal: System::Windows::Forms::Label^  Label7;
internal: System::Windows::Forms::Label^  Label6;
internal: System::Windows::Forms::Label^  Label5;
internal: System::Windows::Forms::Label^  Label4;
internal: System::Windows::Forms::Label^  Label3;
internal: 
internal: 

		 ZPlay::TCallbackFunc ^CallbackFunc;


		void SetText(System::String ^text)
		{

			// InvokeRequired required compares the thread ID of the
			// calling thread to the thread ID of the creating thread.
			// If these threads are different, it returns true.
			if (this->callback_text->InvokeRequired)
			{
				SetTextCallback ^d = gcnew SetTextCallback(this, &Form1::SetText);
				this->Invoke(d, gcnew array<System::Object^> {text});
			}
			else
			{
				this->callback_text->Text = text;
			}
		}

			 ZPlay ^player;
			 int LoadMode;
			 bool  FadeFinished;
			 bool Echo;
			 bool ReverseMode;
			 bool SideCut;
			 bool VocalCut;
			 bool NextSong;

	
	protected: 
			

	protected: 
	private: System::Windows::Forms::Button^  button1;
	private: System::Windows::Forms::Timer^  Timer1;
	private: System::Windows::Forms::Timer^  Timer2;
	private: System::Windows::Forms::ProgressBar^  ProgressBar1;



	private: System::Windows::Forms::GroupBox^  groupBox2;
	private: System::Windows::Forms::Label^  descr;
	private: System::Windows::Forms::Label^  descr1;
	private: System::Windows::Forms::Button^  button2;
	private: System::Windows::Forms::Button^  button3;
	private: System::Windows::Forms::Button^  button4;
	private: System::Windows::Forms::Button^  button5;
	private: System::Windows::Forms::GroupBox^  groupBox3;
	private: System::Windows::Forms::Label^  position;
	private: System::Windows::Forms::GroupBox^  groupBox4;
	private: System::Windows::Forms::Label^  statusvalue2;
	private: System::Windows::Forms::Label^  statuslabel2;
	private: System::Windows::Forms::Label^  statusvalue1;
	private: System::Windows::Forms::Label^  statuslabel1;

	private: System::Windows::Forms::VScrollBar^  leftplayervolume;

	private: System::Windows::Forms::GroupBox^  groupBox6;
	private: System::Windows::Forms::VScrollBar^  rightplayervolume;
	private: System::Windows::Forms::VScrollBar^  rightmastervolume;
	private: System::Windows::Forms::VScrollBar^  leftmastervolume;
private: System::Windows::Forms::Button^  button6;
private: System::Windows::Forms::Button^  button7;
private: System::Windows::Forms::Button^  button8;
private: System::Windows::Forms::Button^  button9;
private: System::Windows::Forms::Button^  button10;
private: System::Windows::Forms::Button^  button11;
private: System::Windows::Forms::Button^  button12;
private: System::Windows::Forms::Button^  button13;
private: System::Windows::Forms::Button^  button14;
private: System::Windows::Forms::Button^  button15;
private: System::Windows::Forms::GroupBox^  groupBox7;
private: System::Windows::Forms::VScrollBar^  vScrollBar3;
private: System::Windows::Forms::VScrollBar^  vScrollBar2;
private: System::Windows::Forms::VScrollBar^  vScrollBar1;
private: System::Windows::Forms::GroupBox^  groupBox8;
private: System::Windows::Forms::VScrollBar^  vScrollBar14;
private: System::Windows::Forms::VScrollBar^  vScrollBar13;
private: System::Windows::Forms::VScrollBar^  vScrollBar12;
private: System::Windows::Forms::VScrollBar^  vScrollBar11;
private: System::Windows::Forms::VScrollBar^  vScrollBar10;
private: System::Windows::Forms::VScrollBar^  vScrollBar9;
private: System::Windows::Forms::VScrollBar^  vScrollBar8;
private: System::Windows::Forms::VScrollBar^  vScrollBar7;
private: System::Windows::Forms::VScrollBar^  vScrollBar6;
private: System::Windows::Forms::VScrollBar^  vScrollBar5;
private: System::Windows::Forms::VScrollBar^  vScrollBar4;
private: System::Windows::Forms::CheckBox^  checkBox1;
private: System::Windows::Forms::ProgressBar^  leftvu;
private: System::Windows::Forms::ProgressBar^  rightvu;
private: System::Windows::Forms::GroupBox^  groupBox9;
private: System::Windows::Forms::CheckBox^  checkBox4;
private: System::Windows::Forms::CheckBox^  FFTLinear;

private: System::Windows::Forms::CheckBox^  FFTEnabled;

internal: System::Windows::Forms::ComboBox^  ComboBox2;
private: 
internal: System::Windows::Forms::ComboBox^  ComboBox3;
internal: System::Windows::Forms::ComboBox^  ComboBox1;
private: System::Windows::Forms::PictureBox^  PictureBox1;
internal: 

internal: 





	private: System::ComponentModel::IContainer^  components;

	private:
		/// <summary>
		/// Required designer variable.
		/// </summary>


#pragma region Windows Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		void InitializeComponent(void)
		{
			this->components = (gcnew System::ComponentModel::Container());
			this->OpenFileDialog1 = (gcnew System::Windows::Forms::OpenFileDialog());
			this->button1 = (gcnew System::Windows::Forms::Button());
			this->Timer1 = (gcnew System::Windows::Forms::Timer(this->components));
			this->Timer2 = (gcnew System::Windows::Forms::Timer(this->components));
			this->ProgressBar1 = (gcnew System::Windows::Forms::ProgressBar());
			this->button16 = (gcnew System::Windows::Forms::Button());
			this->groupBox2 = (gcnew System::Windows::Forms::GroupBox());
			this->descr1 = (gcnew System::Windows::Forms::Label());
			this->descr = (gcnew System::Windows::Forms::Label());
			this->button2 = (gcnew System::Windows::Forms::Button());
			this->button3 = (gcnew System::Windows::Forms::Button());
			this->button4 = (gcnew System::Windows::Forms::Button());
			this->button5 = (gcnew System::Windows::Forms::Button());
			this->groupBox3 = (gcnew System::Windows::Forms::GroupBox());
			this->position = (gcnew System::Windows::Forms::Label());
			this->groupBox4 = (gcnew System::Windows::Forms::GroupBox());
			this->statusvalue2 = (gcnew System::Windows::Forms::Label());
			this->statuslabel2 = (gcnew System::Windows::Forms::Label());
			this->statusvalue1 = (gcnew System::Windows::Forms::Label());
			this->statuslabel1 = (gcnew System::Windows::Forms::Label());
			this->rightplayervolume = (gcnew System::Windows::Forms::VScrollBar());
			this->leftplayervolume = (gcnew System::Windows::Forms::VScrollBar());
			this->groupBox6 = (gcnew System::Windows::Forms::GroupBox());
			this->rightmastervolume = (gcnew System::Windows::Forms::VScrollBar());
			this->leftmastervolume = (gcnew System::Windows::Forms::VScrollBar());
			this->button6 = (gcnew System::Windows::Forms::Button());
			this->button7 = (gcnew System::Windows::Forms::Button());
			this->button8 = (gcnew System::Windows::Forms::Button());
			this->button9 = (gcnew System::Windows::Forms::Button());
			this->button10 = (gcnew System::Windows::Forms::Button());
			this->button11 = (gcnew System::Windows::Forms::Button());
			this->button12 = (gcnew System::Windows::Forms::Button());
			this->button13 = (gcnew System::Windows::Forms::Button());
			this->button14 = (gcnew System::Windows::Forms::Button());
			this->button15 = (gcnew System::Windows::Forms::Button());
			this->groupBox7 = (gcnew System::Windows::Forms::GroupBox());
			this->vScrollBar3 = (gcnew System::Windows::Forms::VScrollBar());
			this->vScrollBar2 = (gcnew System::Windows::Forms::VScrollBar());
			this->vScrollBar1 = (gcnew System::Windows::Forms::VScrollBar());
			this->groupBox8 = (gcnew System::Windows::Forms::GroupBox());
			this->checkBox1 = (gcnew System::Windows::Forms::CheckBox());
			this->vScrollBar14 = (gcnew System::Windows::Forms::VScrollBar());
			this->vScrollBar13 = (gcnew System::Windows::Forms::VScrollBar());
			this->vScrollBar12 = (gcnew System::Windows::Forms::VScrollBar());
			this->vScrollBar11 = (gcnew System::Windows::Forms::VScrollBar());
			this->vScrollBar10 = (gcnew System::Windows::Forms::VScrollBar());
			this->vScrollBar9 = (gcnew System::Windows::Forms::VScrollBar());
			this->vScrollBar8 = (gcnew System::Windows::Forms::VScrollBar());
			this->vScrollBar7 = (gcnew System::Windows::Forms::VScrollBar());
			this->vScrollBar6 = (gcnew System::Windows::Forms::VScrollBar());
			this->vScrollBar5 = (gcnew System::Windows::Forms::VScrollBar());
			this->vScrollBar4 = (gcnew System::Windows::Forms::VScrollBar());
			this->leftvu = (gcnew System::Windows::Forms::ProgressBar());
			this->rightvu = (gcnew System::Windows::Forms::ProgressBar());
			this->groupBox9 = (gcnew System::Windows::Forms::GroupBox());
			this->checkBox2 = (gcnew System::Windows::Forms::CheckBox());
			this->PictureBox1 = (gcnew System::Windows::Forms::PictureBox());
			this->ComboBox2 = (gcnew System::Windows::Forms::ComboBox());
			this->ComboBox3 = (gcnew System::Windows::Forms::ComboBox());
			this->ComboBox1 = (gcnew System::Windows::Forms::ComboBox());
			this->checkBox4 = (gcnew System::Windows::Forms::CheckBox());
			this->FFTLinear = (gcnew System::Windows::Forms::CheckBox());
			this->FFTEnabled = (gcnew System::Windows::Forms::CheckBox());
			this->callback_text = (gcnew System::Windows::Forms::Label());
			this->button17 = (gcnew System::Windows::Forms::Button());
			this->button18 = (gcnew System::Windows::Forms::Button());
			this->pictureBox2 = (gcnew System::Windows::Forms::PictureBox());
			this->saveFileDialog1 = (gcnew System::Windows::Forms::SaveFileDialog());
			this->groupBox10 = (gcnew System::Windows::Forms::GroupBox());
			this->Button20 = (gcnew System::Windows::Forms::Button());
			this->CheckBox3 = (gcnew System::Windows::Forms::CheckBox());
			this->Label2 = (gcnew System::Windows::Forms::Label());
			this->Label1 = (gcnew System::Windows::Forms::Label());
			this->ComboBox5 = (gcnew System::Windows::Forms::ComboBox());
			this->ComboBox4 = (gcnew System::Windows::Forms::ComboBox());
			this->groupBox5 = (gcnew System::Windows::Forms::GroupBox());
			this->groupBox1 = (gcnew System::Windows::Forms::GroupBox());
			this->Label16 = (gcnew System::Windows::Forms::Label());
			this->Label15 = (gcnew System::Windows::Forms::Label());
			this->Label14 = (gcnew System::Windows::Forms::Label());
			this->Label13 = (gcnew System::Windows::Forms::Label());
			this->Label12 = (gcnew System::Windows::Forms::Label());
			this->Label11 = (gcnew System::Windows::Forms::Label());
			this->Label10 = (gcnew System::Windows::Forms::Label());
			this->Label9 = (gcnew System::Windows::Forms::Label());
			this->Label8 = (gcnew System::Windows::Forms::Label());
			this->Label7 = (gcnew System::Windows::Forms::Label());
			this->Label6 = (gcnew System::Windows::Forms::Label());
			this->Label5 = (gcnew System::Windows::Forms::Label());
			this->Label4 = (gcnew System::Windows::Forms::Label());
			this->Label3 = (gcnew System::Windows::Forms::Label());
			this->groupBox2->SuspendLayout();
			this->groupBox3->SuspendLayout();
			this->groupBox4->SuspendLayout();
			this->groupBox6->SuspendLayout();
			this->groupBox7->SuspendLayout();
			this->groupBox8->SuspendLayout();
			this->groupBox9->SuspendLayout();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^  >(this->PictureBox1))->BeginInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^  >(this->pictureBox2))->BeginInit();
			this->groupBox10->SuspendLayout();
			this->groupBox5->SuspendLayout();
			this->groupBox1->SuspendLayout();
			this->SuspendLayout();
			// 
			// OpenFileDialog1
			// 
			this->OpenFileDialog1->Filter = L"All Supported Files|*.mp3;*.mp2;*.mp1;*.ogg;*.oga;*.flac;*.wav;*.ac3;*.aac|Mp3 Fi" 
				L"les|*.mp3|Mp2 Files|*.mp2|Mp1 Files|*.mp1|Ogg Files|*.ogg|FLAC files|*.flac|Wav " 
				L"files|*.wav|AC-3|*.ac3|AAC|*.aac";
			this->OpenFileDialog1->Title = L"Open song";
			this->OpenFileDialog1->FileOk += gcnew System::ComponentModel::CancelEventHandler(this, &Form1::openFileDialog1_FileOk);
			// 
			// button1
			// 
			this->button1->Location = System::Drawing::Point(12, 1);
			this->button1->Name = L"button1";
			this->button1->Size = System::Drawing::Size(132, 21);
			this->button1->TabIndex = 0;
			this->button1->Text = L"Open file";
			this->button1->UseVisualStyleBackColor = true;
			this->button1->Click += gcnew System::EventHandler(this, &Form1::button1_Click);
			// 
			// Timer1
			// 
			this->Timer1->Interval = 200;
			this->Timer1->Tick += gcnew System::EventHandler(this, &Form1::Timer1_Tick);
			// 
			// Timer2
			// 
			this->Timer2->Interval = 50;
			this->Timer2->Tick += gcnew System::EventHandler(this, &Form1::Timer2_Tick);
			// 
			// ProgressBar1
			// 
			this->ProgressBar1->Location = System::Drawing::Point(12, 266);
			this->ProgressBar1->Name = L"ProgressBar1";
			this->ProgressBar1->Size = System::Drawing::Size(271, 23);
			this->ProgressBar1->Step = 1;
			this->ProgressBar1->Style = System::Windows::Forms::ProgressBarStyle::Continuous;
			this->ProgressBar1->TabIndex = 1;
			this->ProgressBar1->MouseClick += gcnew System::Windows::Forms::MouseEventHandler(this, &Form1::ProgressBar1_MouseClick);
			// 
			// button16
			// 
			this->button16->Location = System::Drawing::Point(12, 28);
			this->button16->Name = L"button16";
			this->button16->Size = System::Drawing::Size(132, 21);
			this->button16->TabIndex = 28;
			this->button16->Text = L"Open static stream";
			this->button16->UseVisualStyleBackColor = true;
			this->button16->Click += gcnew System::EventHandler(this, &Form1::button16_Click);
			// 
			// groupBox2
			// 
			this->groupBox2->Controls->Add(this->descr1);
			this->groupBox2->Controls->Add(this->descr);
			this->groupBox2->Location = System::Drawing::Point(290, 1);
			this->groupBox2->Name = L"groupBox2";
			this->groupBox2->Size = System::Drawing::Size(296, 108);
			this->groupBox2->TabIndex = 3;
			this->groupBox2->TabStop = false;
			this->groupBox2->Text = L"Info";
			// 
			// descr1
			// 
			this->descr1->Location = System::Drawing::Point(97, 16);
			this->descr1->Name = L"descr1";
			this->descr1->Size = System::Drawing::Size(193, 83);
			this->descr1->TabIndex = 1;
			// 
			// descr
			// 
			this->descr->Location = System::Drawing::Point(7, 16);
			this->descr->Name = L"descr";
			this->descr->Size = System::Drawing::Size(84, 83);
			this->descr->TabIndex = 0;
			// 
			// button2
			// 
			this->button2->Location = System::Drawing::Point(12, 130);
			this->button2->Name = L"button2";
			this->button2->Size = System::Drawing::Size(63, 23);
			this->button2->TabIndex = 4;
			this->button2->Text = L"Play";
			this->button2->UseVisualStyleBackColor = true;
			this->button2->Click += gcnew System::EventHandler(this, &Form1::button2_Click);
			// 
			// button3
			// 
			this->button3->Location = System::Drawing::Point(152, 130);
			this->button3->Name = L"button3";
			this->button3->Size = System::Drawing::Size(63, 23);
			this->button3->TabIndex = 5;
			this->button3->Text = L"Resume";
			this->button3->UseVisualStyleBackColor = true;
			this->button3->Click += gcnew System::EventHandler(this, &Form1::button3_Click);
			// 
			// button4
			// 
			this->button4->Location = System::Drawing::Point(81, 130);
			this->button4->Name = L"button4";
			this->button4->Size = System::Drawing::Size(63, 23);
			this->button4->TabIndex = 6;
			this->button4->Text = L"Pause";
			this->button4->UseVisualStyleBackColor = true;
			this->button4->Click += gcnew System::EventHandler(this, &Form1::button4_Click);
			// 
			// button5
			// 
			this->button5->Location = System::Drawing::Point(220, 130);
			this->button5->Name = L"button5";
			this->button5->Size = System::Drawing::Size(63, 23);
			this->button5->TabIndex = 7;
			this->button5->Text = L"Stop";
			this->button5->UseVisualStyleBackColor = true;
			this->button5->Click += gcnew System::EventHandler(this, &Form1::button5_Click);
			// 
			// groupBox3
			// 
			this->groupBox3->Controls->Add(this->position);
			this->groupBox3->Location = System::Drawing::Point(12, 217);
			this->groupBox3->Name = L"groupBox3";
			this->groupBox3->Size = System::Drawing::Size(109, 41);
			this->groupBox3->TabIndex = 8;
			this->groupBox3->TabStop = false;
			this->groupBox3->Text = L"Position";
			// 
			// position
			// 
			this->position->Location = System::Drawing::Point(6, 16);
			this->position->Name = L"position";
			this->position->Size = System::Drawing::Size(97, 20);
			this->position->TabIndex = 0;
			// 
			// groupBox4
			// 
			this->groupBox4->Controls->Add(this->statusvalue2);
			this->groupBox4->Controls->Add(this->statuslabel2);
			this->groupBox4->Controls->Add(this->statusvalue1);
			this->groupBox4->Controls->Add(this->statuslabel1);
			this->groupBox4->Location = System::Drawing::Point(12, 295);
			this->groupBox4->Name = L"groupBox4";
			this->groupBox4->Size = System::Drawing::Size(271, 117);
			this->groupBox4->TabIndex = 9;
			this->groupBox4->TabStop = false;
			this->groupBox4->Text = L"Status";
			// 
			// statusvalue2
			// 
			this->statusvalue2->Location = System::Drawing::Point(229, 16);
			this->statusvalue2->Name = L"statusvalue2";
			this->statusvalue2->Size = System::Drawing::Size(36, 91);
			this->statusvalue2->TabIndex = 3;
			// 
			// statuslabel2
			// 
			this->statuslabel2->Location = System::Drawing::Point(125, 16);
			this->statuslabel2->Name = L"statuslabel2";
			this->statuslabel2->Size = System::Drawing::Size(98, 91);
			this->statuslabel2->TabIndex = 2;
			// 
			// statusvalue1
			// 
			this->statusvalue1->Location = System::Drawing::Point(82, 16);
			this->statusvalue1->Name = L"statusvalue1";
			this->statusvalue1->Size = System::Drawing::Size(37, 91);
			this->statusvalue1->TabIndex = 1;
			// 
			// statuslabel1
			// 
			this->statuslabel1->Location = System::Drawing::Point(6, 16);
			this->statuslabel1->Name = L"statuslabel1";
			this->statuslabel1->Size = System::Drawing::Size(70, 91);
			this->statuslabel1->TabIndex = 0;
			// 
			// rightplayervolume
			// 
			this->rightplayervolume->LargeChange = 1;
			this->rightplayervolume->Location = System::Drawing::Point(128, 16);
			this->rightplayervolume->Name = L"rightplayervolume";
			this->rightplayervolume->Size = System::Drawing::Size(17, 114);
			this->rightplayervolume->TabIndex = 1;
			this->rightplayervolume->Scroll += gcnew System::Windows::Forms::ScrollEventHandler(this, &Form1::rightplayervolume_Scroll);
			// 
			// leftplayervolume
			// 
			this->leftplayervolume->LargeChange = 1;
			this->leftplayervolume->Location = System::Drawing::Point(85, 16);
			this->leftplayervolume->Name = L"leftplayervolume";
			this->leftplayervolume->Size = System::Drawing::Size(17, 114);
			this->leftplayervolume->TabIndex = 0;
			this->leftplayervolume->Scroll += gcnew System::Windows::Forms::ScrollEventHandler(this, &Form1::leftplayervolume_Scroll);
			// 
			// groupBox6
			// 
			this->groupBox6->Controls->Add(this->rightplayervolume);
			this->groupBox6->Controls->Add(this->rightmastervolume);
			this->groupBox6->Controls->Add(this->leftplayervolume);
			this->groupBox6->Controls->Add(this->leftmastervolume);
			this->groupBox6->Location = System::Drawing::Point(592, 1);
			this->groupBox6->Name = L"groupBox6";
			this->groupBox6->Size = System::Drawing::Size(178, 141);
			this->groupBox6->TabIndex = 11;
			this->groupBox6->TabStop = false;
			this->groupBox6->Text = L"Master - Player volume";
			// 
			// rightmastervolume
			// 
			this->rightmastervolume->LargeChange = 1;
			this->rightmastervolume->Location = System::Drawing::Point(39, 16);
			this->rightmastervolume->Name = L"rightmastervolume";
			this->rightmastervolume->Size = System::Drawing::Size(17, 114);
			this->rightmastervolume->TabIndex = 2;
			this->rightmastervolume->Scroll += gcnew System::Windows::Forms::ScrollEventHandler(this, &Form1::rightmastervolume_Scroll);
			// 
			// leftmastervolume
			// 
			this->leftmastervolume->LargeChange = 1;
			this->leftmastervolume->Location = System::Drawing::Point(11, 16);
			this->leftmastervolume->Name = L"leftmastervolume";
			this->leftmastervolume->Size = System::Drawing::Size(17, 114);
			this->leftmastervolume->TabIndex = 1;
			this->leftmastervolume->Scroll += gcnew System::Windows::Forms::ScrollEventHandler(this, &Form1::leftmastervolume_Scroll);
			// 
			// button6
			// 
			this->button6->Location = System::Drawing::Point(220, 183);
			this->button6->Name = L"button6";
			this->button6->Size = System::Drawing::Size(63, 23);
			this->button6->TabIndex = 12;
			this->button6->Text = L"Side cut";
			this->button6->UseVisualStyleBackColor = true;
			this->button6->Click += gcnew System::EventHandler(this, &Form1::button6_Click);
			// 
			// button7
			// 
			this->button7->Location = System::Drawing::Point(150, 183);
			this->button7->Name = L"button7";
			this->button7->Size = System::Drawing::Size(63, 23);
			this->button7->TabIndex = 13;
			this->button7->Text = L"Vocal cut";
			this->button7->UseVisualStyleBackColor = true;
			this->button7->Click += gcnew System::EventHandler(this, &Form1::button7_Click);
			// 
			// button8
			// 
			this->button8->Location = System::Drawing::Point(81, 183);
			this->button8->Name = L"button8";
			this->button8->Size = System::Drawing::Size(63, 23);
			this->button8->TabIndex = 14;
			this->button8->Text = L"Fade out";
			this->button8->UseVisualStyleBackColor = true;
			this->button8->Click += gcnew System::EventHandler(this, &Form1::button8_Click);
			// 
			// button9
			// 
			this->button9->Location = System::Drawing::Point(12, 183);
			this->button9->Name = L"button9";
			this->button9->Size = System::Drawing::Size(63, 23);
			this->button9->TabIndex = 15;
			this->button9->Text = L"Fade in";
			this->button9->UseVisualStyleBackColor = true;
			this->button9->Click += gcnew System::EventHandler(this, &Form1::button9_Click);
			// 
			// button10
			// 
			this->button10->Location = System::Drawing::Point(220, 156);
			this->button10->Name = L"button10";
			this->button10->Size = System::Drawing::Size(63, 23);
			this->button10->TabIndex = 16;
			this->button10->Text = L"Echo";
			this->button10->UseVisualStyleBackColor = true;
			this->button10->Click += gcnew System::EventHandler(this, &Form1::button10_Click);
			// 
			// button11
			// 
			this->button11->Location = System::Drawing::Point(150, 156);
			this->button11->Name = L"button11";
			this->button11->Size = System::Drawing::Size(63, 23);
			this->button11->TabIndex = 17;
			this->button11->Text = L"Loop 2";
			this->button11->UseVisualStyleBackColor = true;
			this->button11->Click += gcnew System::EventHandler(this, &Form1::button11_Click);
			// 
			// button12
			// 
			this->button12->Location = System::Drawing::Point(81, 156);
			this->button12->Name = L"button12";
			this->button12->Size = System::Drawing::Size(63, 23);
			this->button12->TabIndex = 18;
			this->button12->Text = L"Jump fwd";
			this->button12->UseVisualStyleBackColor = true;
			this->button12->Click += gcnew System::EventHandler(this, &Form1::button12_Click);
			// 
			// button13
			// 
			this->button13->Location = System::Drawing::Point(12, 156);
			this->button13->Name = L"button13";
			this->button13->Size = System::Drawing::Size(63, 23);
			this->button13->TabIndex = 19;
			this->button13->Text = L"Jump rew";
			this->button13->UseVisualStyleBackColor = true;
			this->button13->Click += gcnew System::EventHandler(this, &Form1::button13_Click);
			// 
			// button14
			// 
			this->button14->Location = System::Drawing::Point(150, 239);
			this->button14->Name = L"button14";
			this->button14->Size = System::Drawing::Size(132, 23);
			this->button14->TabIndex = 20;
			this->button14->Text = L"Detect BPM";
			this->button14->UseVisualStyleBackColor = true;
			this->button14->Click += gcnew System::EventHandler(this, &Form1::button14_Click);
			// 
			// button15
			// 
			this->button15->Location = System::Drawing::Point(150, 210);
			this->button15->Name = L"button15";
			this->button15->Size = System::Drawing::Size(132, 23);
			this->button15->TabIndex = 21;
			this->button15->Text = L"Reverse mode";
			this->button15->UseVisualStyleBackColor = true;
			this->button15->Click += gcnew System::EventHandler(this, &Form1::button15_Click);
			// 
			// groupBox7
			// 
			this->groupBox7->Controls->Add(this->vScrollBar3);
			this->groupBox7->Controls->Add(this->vScrollBar2);
			this->groupBox7->Controls->Add(this->vScrollBar1);
			this->groupBox7->Location = System::Drawing::Point(592, 151);
			this->groupBox7->Name = L"groupBox7";
			this->groupBox7->Size = System::Drawing::Size(79, 141);
			this->groupBox7->TabIndex = 22;
			this->groupBox7->TabStop = false;
			this->groupBox7->Text = L"PTR";
			// 
			// vScrollBar3
			// 
			this->vScrollBar3->LargeChange = 1;
			this->vScrollBar3->Location = System::Drawing::Point(56, 21);
			this->vScrollBar3->Maximum = 200;
			this->vScrollBar3->Name = L"vScrollBar3";
			this->vScrollBar3->Size = System::Drawing::Size(17, 114);
			this->vScrollBar3->TabIndex = 3;
			this->vScrollBar3->Value = 100;
			this->vScrollBar3->Scroll += gcnew System::Windows::Forms::ScrollEventHandler(this, &Form1::vScrollBar3_Scroll);
			// 
			// vScrollBar2
			// 
			this->vScrollBar2->LargeChange = 1;
			this->vScrollBar2->Location = System::Drawing::Point(30, 21);
			this->vScrollBar2->Maximum = 200;
			this->vScrollBar2->Name = L"vScrollBar2";
			this->vScrollBar2->Size = System::Drawing::Size(17, 114);
			this->vScrollBar2->TabIndex = 2;
			this->vScrollBar2->Value = 100;
			this->vScrollBar2->Scroll += gcnew System::Windows::Forms::ScrollEventHandler(this, &Form1::vScrollBar2_Scroll);
			// 
			// vScrollBar1
			// 
			this->vScrollBar1->LargeChange = 1;
			this->vScrollBar1->Location = System::Drawing::Point(3, 21);
			this->vScrollBar1->Maximum = 200;
			this->vScrollBar1->Name = L"vScrollBar1";
			this->vScrollBar1->Size = System::Drawing::Size(17, 114);
			this->vScrollBar1->TabIndex = 1;
			this->vScrollBar1->Value = 100;
			this->vScrollBar1->Scroll += gcnew System::Windows::Forms::ScrollEventHandler(this, &Form1::vScrollBar1_Scroll);
			// 
			// groupBox8
			// 
			this->groupBox8->Controls->Add(this->checkBox1);
			this->groupBox8->Controls->Add(this->vScrollBar14);
			this->groupBox8->Controls->Add(this->vScrollBar13);
			this->groupBox8->Controls->Add(this->vScrollBar12);
			this->groupBox8->Controls->Add(this->vScrollBar11);
			this->groupBox8->Controls->Add(this->vScrollBar10);
			this->groupBox8->Controls->Add(this->vScrollBar9);
			this->groupBox8->Controls->Add(this->vScrollBar8);
			this->groupBox8->Controls->Add(this->vScrollBar7);
			this->groupBox8->Controls->Add(this->vScrollBar6);
			this->groupBox8->Controls->Add(this->vScrollBar5);
			this->groupBox8->Controls->Add(this->vScrollBar4);
			this->groupBox8->Location = System::Drawing::Point(290, 264);
			this->groupBox8->Name = L"groupBox8";
			this->groupBox8->Size = System::Drawing::Size(296, 148);
			this->groupBox8->TabIndex = 23;
			this->groupBox8->TabStop = false;
			this->groupBox8->Text = L"Equalizer";
			// 
			// checkBox1
			// 
			this->checkBox1->AutoSize = true;
			this->checkBox1->Location = System::Drawing::Point(6, 19);
			this->checkBox1->Name = L"checkBox1";
			this->checkBox1->Size = System::Drawing::Size(59, 17);
			this->checkBox1->TabIndex = 12;
			this->checkBox1->Text = L"Enable";
			this->checkBox1->UseVisualStyleBackColor = true;
			this->checkBox1->CheckedChanged += gcnew System::EventHandler(this, &Form1::checkBox1_CheckedChanged);
			// 
			// vScrollBar14
			// 
			this->vScrollBar14->LargeChange = 1;
			this->vScrollBar14->Location = System::Drawing::Point(49, 38);
			this->vScrollBar14->Maximum = 40;
			this->vScrollBar14->Name = L"vScrollBar14";
			this->vScrollBar14->Size = System::Drawing::Size(16, 108);
			this->vScrollBar14->TabIndex = 11;
			this->vScrollBar14->Value = 20;
			this->vScrollBar14->Scroll += gcnew System::Windows::Forms::ScrollEventHandler(this, &Form1::vScrollBar14_Scroll);
			// 
			// vScrollBar13
			// 
			this->vScrollBar13->LargeChange = 1;
			this->vScrollBar13->Location = System::Drawing::Point(73, 38);
			this->vScrollBar13->Maximum = 40;
			this->vScrollBar13->Name = L"vScrollBar13";
			this->vScrollBar13->Size = System::Drawing::Size(16, 108);
			this->vScrollBar13->TabIndex = 10;
			this->vScrollBar13->Value = 20;
			this->vScrollBar13->Scroll += gcnew System::Windows::Forms::ScrollEventHandler(this, &Form1::vScrollBar13_Scroll);
			// 
			// vScrollBar12
			// 
			this->vScrollBar12->LargeChange = 1;
			this->vScrollBar12->Location = System::Drawing::Point(97, 38);
			this->vScrollBar12->Maximum = 40;
			this->vScrollBar12->Name = L"vScrollBar12";
			this->vScrollBar12->Size = System::Drawing::Size(16, 108);
			this->vScrollBar12->TabIndex = 9;
			this->vScrollBar12->Value = 20;
			this->vScrollBar12->Scroll += gcnew System::Windows::Forms::ScrollEventHandler(this, &Form1::vScrollBar12_Scroll);
			// 
			// vScrollBar11
			// 
			this->vScrollBar11->LargeChange = 1;
			this->vScrollBar11->Location = System::Drawing::Point(265, 38);
			this->vScrollBar11->Maximum = 40;
			this->vScrollBar11->Name = L"vScrollBar11";
			this->vScrollBar11->Size = System::Drawing::Size(16, 108);
			this->vScrollBar11->TabIndex = 8;
			this->vScrollBar11->Value = 20;
			this->vScrollBar11->Scroll += gcnew System::Windows::Forms::ScrollEventHandler(this, &Form1::vScrollBar11_Scroll);
			// 
			// vScrollBar10
			// 
			this->vScrollBar10->LargeChange = 1;
			this->vScrollBar10->Location = System::Drawing::Point(241, 38);
			this->vScrollBar10->Maximum = 40;
			this->vScrollBar10->Name = L"vScrollBar10";
			this->vScrollBar10->Size = System::Drawing::Size(16, 108);
			this->vScrollBar10->TabIndex = 7;
			this->vScrollBar10->Value = 20;
			// 
			// vScrollBar9
			// 
			this->vScrollBar9->LargeChange = 1;
			this->vScrollBar9->Location = System::Drawing::Point(217, 38);
			this->vScrollBar9->Maximum = 40;
			this->vScrollBar9->Name = L"vScrollBar9";
			this->vScrollBar9->Size = System::Drawing::Size(16, 108);
			this->vScrollBar9->TabIndex = 6;
			this->vScrollBar9->Value = 20;
			this->vScrollBar9->Scroll += gcnew System::Windows::Forms::ScrollEventHandler(this, &Form1::vScrollBar9_Scroll);
			// 
			// vScrollBar8
			// 
			this->vScrollBar8->LargeChange = 1;
			this->vScrollBar8->Location = System::Drawing::Point(193, 38);
			this->vScrollBar8->Maximum = 40;
			this->vScrollBar8->Name = L"vScrollBar8";
			this->vScrollBar8->Size = System::Drawing::Size(16, 108);
			this->vScrollBar8->TabIndex = 5;
			this->vScrollBar8->Value = 20;
			this->vScrollBar8->Scroll += gcnew System::Windows::Forms::ScrollEventHandler(this, &Form1::vScrollBar8_Scroll);
			// 
			// vScrollBar7
			// 
			this->vScrollBar7->LargeChange = 1;
			this->vScrollBar7->Location = System::Drawing::Point(169, 38);
			this->vScrollBar7->Maximum = 40;
			this->vScrollBar7->Name = L"vScrollBar7";
			this->vScrollBar7->Size = System::Drawing::Size(16, 108);
			this->vScrollBar7->TabIndex = 4;
			this->vScrollBar7->Value = 20;
			this->vScrollBar7->Scroll += gcnew System::Windows::Forms::ScrollEventHandler(this, &Form1::vScrollBar7_Scroll);
			// 
			// vScrollBar6
			// 
			this->vScrollBar6->LargeChange = 1;
			this->vScrollBar6->Location = System::Drawing::Point(121, 38);
			this->vScrollBar6->Maximum = 40;
			this->vScrollBar6->Name = L"vScrollBar6";
			this->vScrollBar6->Size = System::Drawing::Size(16, 108);
			this->vScrollBar6->TabIndex = 3;
			this->vScrollBar6->Value = 20;
			this->vScrollBar6->Scroll += gcnew System::Windows::Forms::ScrollEventHandler(this, &Form1::vScrollBar6_Scroll);
			// 
			// vScrollBar5
			// 
			this->vScrollBar5->LargeChange = 1;
			this->vScrollBar5->Location = System::Drawing::Point(145, 38);
			this->vScrollBar5->Maximum = 40;
			this->vScrollBar5->Name = L"vScrollBar5";
			this->vScrollBar5->Size = System::Drawing::Size(16, 108);
			this->vScrollBar5->TabIndex = 2;
			this->vScrollBar5->Value = 20;
			this->vScrollBar5->Scroll += gcnew System::Windows::Forms::ScrollEventHandler(this, &Form1::vScrollBar5_Scroll);
			// 
			// vScrollBar4
			// 
			this->vScrollBar4->LargeChange = 1;
			this->vScrollBar4->Location = System::Drawing::Point(16, 38);
			this->vScrollBar4->Maximum = 40;
			this->vScrollBar4->Name = L"vScrollBar4";
			this->vScrollBar4->Size = System::Drawing::Size(16, 108);
			this->vScrollBar4->TabIndex = 1;
			this->vScrollBar4->Value = 20;
			this->vScrollBar4->Scroll += gcnew System::Windows::Forms::ScrollEventHandler(this, &Form1::vScrollBar4_Scroll);
			// 
			// leftvu
			// 
			this->leftvu->Location = System::Drawing::Point(674, 233);
			this->leftvu->Name = L"leftvu";
			this->leftvu->Size = System::Drawing::Size(102, 25);
			this->leftvu->Step = 1;
			this->leftvu->Style = System::Windows::Forms::ProgressBarStyle::Continuous;
			this->leftvu->TabIndex = 24;
			// 
			// rightvu
			// 
			this->rightvu->Location = System::Drawing::Point(674, 266);
			this->rightvu->Name = L"rightvu";
			this->rightvu->Size = System::Drawing::Size(102, 25);
			this->rightvu->Step = 1;
			this->rightvu->Style = System::Windows::Forms::ProgressBarStyle::Continuous;
			this->rightvu->TabIndex = 25;
			// 
			// groupBox9
			// 
			this->groupBox9->Controls->Add(this->checkBox2);
			this->groupBox9->Controls->Add(this->PictureBox1);
			this->groupBox9->Controls->Add(this->ComboBox2);
			this->groupBox9->Controls->Add(this->ComboBox3);
			this->groupBox9->Controls->Add(this->ComboBox1);
			this->groupBox9->Controls->Add(this->checkBox4);
			this->groupBox9->Controls->Add(this->FFTLinear);
			this->groupBox9->Controls->Add(this->FFTEnabled);
			this->groupBox9->Location = System::Drawing::Point(8, 418);
			this->groupBox9->Name = L"groupBox9";
			this->groupBox9->Size = System::Drawing::Size(578, 152);
			this->groupBox9->TabIndex = 26;
			this->groupBox9->TabStop = false;
			this->groupBox9->Text = L"FFT";
			// 
			// checkBox2
			// 
			this->checkBox2->AutoSize = true;
			this->checkBox2->Checked = true;
			this->checkBox2->CheckState = System::Windows::Forms::CheckState::Checked;
			this->checkBox2->Location = System::Drawing::Point(178, 129);
			this->checkBox2->Name = L"checkBox2";
			this->checkBox2->Size = System::Drawing::Size(53, 17);
			this->checkBox2->TabIndex = 9;
			this->checkBox2->Text = L"Scale";
			this->checkBox2->UseVisualStyleBackColor = true;
			this->checkBox2->CheckedChanged += gcnew System::EventHandler(this, &Form1::checkBox2_CheckedChanged);
			// 
			// PictureBox1
			// 
			this->PictureBox1->Location = System::Drawing::Point(6, 11);
			this->PictureBox1->Name = L"PictureBox1";
			this->PictureBox1->Size = System::Drawing::Size(566, 114);
			this->PictureBox1->TabIndex = 8;
			this->PictureBox1->TabStop = false;
			this->PictureBox1->Paint += gcnew System::Windows::Forms::PaintEventHandler(this, &Form1::pictureBox1_Paint);
			// 
			// ComboBox2
			// 
			this->ComboBox2->DropDownStyle = System::Windows::Forms::ComboBoxStyle::DropDownList;
			this->ComboBox2->FormattingEnabled = true;
			this->ComboBox2->Items->AddRange(gcnew cli::array< System::Object^  >(11) {L"4", L"8", L"16", L"32", L"64", L"128", L"256", 
				L"512", L"1204", L"2048", L"4096"});
			this->ComboBox2->Location = System::Drawing::Point(510, 128);
			this->ComboBox2->Name = L"ComboBox2";
			this->ComboBox2->Size = System::Drawing::Size(58, 21);
			this->ComboBox2->TabIndex = 7;
			this->ComboBox2->SelectedIndexChanged += gcnew System::EventHandler(this, &Form1::ComboBox2_SelectedIndexChanged);
			// 
			// ComboBox3
			// 
			this->ComboBox3->DropDownStyle = System::Windows::Forms::ComboBoxStyle::DropDownList;
			this->ComboBox3->FormattingEnabled = true;
			this->ComboBox3->Items->AddRange(gcnew cli::array< System::Object^  >(14) {L"Rectangular", L"Hamming", L"Hann", L"Cosine", 
				L"Lanczos", L"Bartlett", L"Triangular", L"Gauss", L"Bartlett-Hann", L"Blackman", L"Nuttall", L"Blackman-Harris", L"Blackman-Nuttall", 
				L"Flat-Top"});
			this->ComboBox3->Location = System::Drawing::Point(382, 128);
			this->ComboBox3->Name = L"ComboBox3";
			this->ComboBox3->Size = System::Drawing::Size(122, 21);
			this->ComboBox3->TabIndex = 6;
			this->ComboBox3->SelectedIndexChanged += gcnew System::EventHandler(this, &Form1::ComboBox3_SelectedIndexChanged);
			// 
			// ComboBox1
			// 
			this->ComboBox1->DropDownStyle = System::Windows::Forms::ComboBoxStyle::DropDownList;
			this->ComboBox1->FormattingEnabled = true;
			this->ComboBox1->Items->AddRange(gcnew cli::array< System::Object^  >(7) {L"Lines (Left On Top)", L"Lines (Right On Top)", 
				L"Area (Left On Top)", L"Area (Right On Top)", L"Bars (Left On Top)", L"Bars (Right OnTop)", L"Spectrum"});
			this->ComboBox1->Location = System::Drawing::Point(247, 128);
			this->ComboBox1->Name = L"ComboBox1";
			this->ComboBox1->Size = System::Drawing::Size(129, 21);
			this->ComboBox1->TabIndex = 3;
			this->ComboBox1->SelectedIndexChanged += gcnew System::EventHandler(this, &Form1::ComboBox1_SelectedIndexChanged);
			// 
			// checkBox4
			// 
			this->checkBox4->AutoSize = true;
			this->checkBox4->Checked = true;
			this->checkBox4->CheckState = System::Windows::Forms::CheckState::Checked;
			this->checkBox4->Location = System::Drawing::Point(127, 130);
			this->checkBox4->Name = L"checkBox4";
			this->checkBox4->Size = System::Drawing::Size(45, 17);
			this->checkBox4->TabIndex = 2;
			this->checkBox4->Text = L"Grid";
			this->checkBox4->UseVisualStyleBackColor = true;
			this->checkBox4->CheckedChanged += gcnew System::EventHandler(this, &Form1::checkBox4_CheckedChanged);
			// 
			// FFTLinear
			// 
			this->FFTLinear->AutoSize = true;
			this->FFTLinear->Location = System::Drawing::Point(67, 130);
			this->FFTLinear->Name = L"FFTLinear";
			this->FFTLinear->Size = System::Drawing::Size(55, 17);
			this->FFTLinear->TabIndex = 1;
			this->FFTLinear->Text = L"Linear";
			this->FFTLinear->UseVisualStyleBackColor = true;
			this->FFTLinear->CheckedChanged += gcnew System::EventHandler(this, &Form1::checkBox3_CheckedChanged);
			// 
			// FFTEnabled
			// 
			this->FFTEnabled->AutoSize = true;
			this->FFTEnabled->Checked = true;
			this->FFTEnabled->CheckState = System::Windows::Forms::CheckState::Checked;
			this->FFTEnabled->Location = System::Drawing::Point(6, 130);
			this->FFTEnabled->Name = L"FFTEnabled";
			this->FFTEnabled->Size = System::Drawing::Size(59, 17);
			this->FFTEnabled->TabIndex = 0;
			this->FFTEnabled->Text = L"Enable";
			this->FFTEnabled->UseVisualStyleBackColor = true;
			// 
			// callback_text
			// 
			this->callback_text->Location = System::Drawing::Point(674, 159);
			this->callback_text->Name = L"callback_text";
			this->callback_text->Size = System::Drawing::Size(102, 69);
			this->callback_text->TabIndex = 27;
			this->callback_text->Click += gcnew System::EventHandler(this, &Form1::callback_text_Click);
			// 
			// button17
			// 
			this->button17->Location = System::Drawing::Point(150, 28);
			this->button17->Name = L"button17";
			this->button17->Size = System::Drawing::Size(132, 21);
			this->button17->TabIndex = 28;
			this->button17->Text = L"Open dynamic stream";
			this->button17->UseVisualStyleBackColor = true;
			this->button17->Click += gcnew System::EventHandler(this, &Form1::button17_Click);
			// 
			// button18
			// 
			this->button18->Location = System::Drawing::Point(150, 1);
			this->button18->Name = L"button18";
			this->button18->Size = System::Drawing::Size(132, 21);
			this->button18->TabIndex = 29;
			this->button18->Text = L"Add file";
			this->button18->UseVisualStyleBackColor = true;
			this->button18->Click += gcnew System::EventHandler(this, &Form1::button18_Click);
			// 
			// pictureBox2
			// 
			this->pictureBox2->Location = System::Drawing::Point(3, 13);
			this->pictureBox2->Name = L"pictureBox2";
			this->pictureBox2->Size = System::Drawing::Size(175, 256);
			this->pictureBox2->TabIndex = 30;
			this->pictureBox2->TabStop = false;
			// 
			// saveFileDialog1
			// 
			this->saveFileDialog1->Filter = L"Wave File|*.wav";
			this->saveFileDialog1->Title = L"Save to wave";
			this->saveFileDialog1->FileOk += gcnew System::ComponentModel::CancelEventHandler(this, &Form1::saveFileDialog1_FileOk);
			// 
			// groupBox10
			// 
			this->groupBox10->Controls->Add(this->Button20);
			this->groupBox10->Controls->Add(this->CheckBox3);
			this->groupBox10->Controls->Add(this->Label2);
			this->groupBox10->Controls->Add(this->Label1);
			this->groupBox10->Controls->Add(this->ComboBox5);
			this->groupBox10->Controls->Add(this->ComboBox4);
			this->groupBox10->Location = System::Drawing::Point(10, 55);
			this->groupBox10->Name = L"groupBox10";
			this->groupBox10->Size = System::Drawing::Size(272, 66);
			this->groupBox10->TabIndex = 39;
			this->groupBox10->TabStop = false;
			this->groupBox10->Text = L"Recording";
			// 
			// Button20
			// 
			this->Button20->Location = System::Drawing::Point(10, 42);
			this->Button20->Name = L"Button20";
			this->Button20->Size = System::Drawing::Size(118, 21);
			this->Button20->TabIndex = 8;
			this->Button20->Text = L"Record";
			this->Button20->UseVisualStyleBackColor = true;
			this->Button20->Click += gcnew System::EventHandler(this, &Form1::Button20_Click_1);
			// 
			// CheckBox3
			// 
			this->CheckBox3->AutoSize = true;
			this->CheckBox3->Location = System::Drawing::Point(149, 44);
			this->CheckBox3->Name = L"CheckBox3";
			this->CheckBox3->Size = System::Drawing::Size(111, 17);
			this->CheckBox3->TabIndex = 7;
			this->CheckBox3->Text = L"Play to soundcard";
			this->CheckBox3->UseVisualStyleBackColor = true;
			// 
			// Label2
			// 
			this->Label2->AutoSize = true;
			this->Label2->Location = System::Drawing::Point(133, 22);
			this->Label2->Name = L"Label2";
			this->Label2->Size = System::Drawing::Size(32, 13);
			this->Label2->TabIndex = 6;
			this->Label2->Text = L"Dest:";
			// 
			// Label1
			// 
			this->Label1->AutoSize = true;
			this->Label1->Location = System::Drawing::Point(4, 22);
			this->Label1->Name = L"Label1";
			this->Label1->Size = System::Drawing::Size(26, 13);
			this->Label1->TabIndex = 5;
			this->Label1->Text = L"Src:";
			// 
			// ComboBox5
			// 
			this->ComboBox5->DropDownStyle = System::Windows::Forms::ComboBoxStyle::DropDownList;
			this->ComboBox5->FormattingEnabled = true;
			this->ComboBox5->Items->AddRange(gcnew cli::array< System::Object^  >(8) {L"Soundcard", L"Mp3 File", L"Ogg File", L"FLAC File", 
				L"Flac Ogg File", L"AAC file", L"Wav File", L"PCM File"});
			this->ComboBox5->Location = System::Drawing::Point(171, 19);
			this->ComboBox5->Name = L"ComboBox5";
			this->ComboBox5->Size = System::Drawing::Size(88, 21);
			this->ComboBox5->TabIndex = 4;
			// 
			// ComboBox4
			// 
			this->ComboBox4->DropDownStyle = System::Windows::Forms::ComboBoxStyle::DropDownList;
			this->ComboBox4->FormattingEnabled = true;
			this->ComboBox4->Items->AddRange(gcnew cli::array< System::Object^  >(4) {L"Line In", L"Microphone", L"CD Audio", L"Midi"});
			this->ComboBox4->Location = System::Drawing::Point(36, 19);
			this->ComboBox4->Name = L"ComboBox4";
			this->ComboBox4->Size = System::Drawing::Size(88, 21);
			this->ComboBox4->TabIndex = 3;
			// 
			// groupBox5
			// 
			this->groupBox5->Controls->Add(this->pictureBox2);
			this->groupBox5->Location = System::Drawing::Point(592, 298);
			this->groupBox5->Name = L"groupBox5";
			this->groupBox5->Size = System::Drawing::Size(184, 272);
			this->groupBox5->TabIndex = 40;
			this->groupBox5->TabStop = false;
			this->groupBox5->Text = L"ID3 embeded picture";
			// 
			// groupBox1
			// 
			this->groupBox1->Controls->Add(this->Label16);
			this->groupBox1->Controls->Add(this->Label15);
			this->groupBox1->Controls->Add(this->Label14);
			this->groupBox1->Controls->Add(this->Label13);
			this->groupBox1->Controls->Add(this->Label12);
			this->groupBox1->Controls->Add(this->Label11);
			this->groupBox1->Controls->Add(this->Label10);
			this->groupBox1->Controls->Add(this->Label9);
			this->groupBox1->Controls->Add(this->Label8);
			this->groupBox1->Controls->Add(this->Label7);
			this->groupBox1->Controls->Add(this->Label6);
			this->groupBox1->Controls->Add(this->Label5);
			this->groupBox1->Controls->Add(this->Label4);
			this->groupBox1->Controls->Add(this->Label3);
			this->groupBox1->Location = System::Drawing::Point(288, 113);
			this->groupBox1->Name = L"groupBox1";
			this->groupBox1->Size = System::Drawing::Size(296, 145);
			this->groupBox1->TabIndex = 41;
			this->groupBox1->TabStop = false;
			this->groupBox1->Text = L"ID3";
			// 
			// Label16
			// 
			this->Label16->AutoSize = true;
			this->Label16->Location = System::Drawing::Point(6, 126);
			this->Label16->Name = L"Label16";
			this->Label16->Size = System::Drawing::Size(54, 13);
			this->Label16->TabIndex = 14;
			this->Label16->Text = L"Comment:";
			// 
			// Label15
			// 
			this->Label15->AutoSize = true;
			this->Label15->Location = System::Drawing::Point(6, 107);
			this->Label15->Name = L"Label15";
			this->Label15->Size = System::Drawing::Size(50, 13);
			this->Label15->TabIndex = 13;
			this->Label15->Text = L"Encoder:";
			// 
			// Label14
			// 
			this->Label14->AutoSize = true;
			this->Label14->Location = System::Drawing::Point(6, 88);
			this->Label14->Name = L"Label14";
			this->Label14->Size = System::Drawing::Size(38, 13);
			this->Label14->TabIndex = 12;
			this->Label14->Text = L"Track:";
			// 
			// Label13
			// 
			this->Label13->AutoSize = true;
			this->Label13->Location = System::Drawing::Point(6, 69);
			this->Label13->Name = L"Label13";
			this->Label13->Size = System::Drawing::Size(32, 13);
			this->Label13->TabIndex = 11;
			this->Label13->Text = L"Year:";
			// 
			// Label12
			// 
			this->Label12->AutoSize = true;
			this->Label12->Location = System::Drawing::Point(6, 50);
			this->Label12->Name = L"Label12";
			this->Label12->Size = System::Drawing::Size(39, 13);
			this->Label12->TabIndex = 10;
			this->Label12->Text = L"Album:";
			// 
			// Label11
			// 
			this->Label11->AutoSize = true;
			this->Label11->Location = System::Drawing::Point(6, 31);
			this->Label11->Name = L"Label11";
			this->Label11->Size = System::Drawing::Size(33, 13);
			this->Label11->TabIndex = 9;
			this->Label11->Text = L"Artist:";
			// 
			// Label10
			// 
			this->Label10->AutoSize = true;
			this->Label10->Location = System::Drawing::Point(6, 12);
			this->Label10->Name = L"Label10";
			this->Label10->Size = System::Drawing::Size(30, 13);
			this->Label10->TabIndex = 8;
			this->Label10->Text = L"Title:";
			// 
			// Label9
			// 
			this->Label9->Location = System::Drawing::Point(62, 126);
			this->Label9->Name = L"Label9";
			this->Label9->Size = System::Drawing::Size(225, 16);
			this->Label9->TabIndex = 7;
			// 
			// Label8
			// 
			this->Label8->Location = System::Drawing::Point(62, 107);
			this->Label8->Name = L"Label8";
			this->Label8->Size = System::Drawing::Size(225, 16);
			this->Label8->TabIndex = 6;
			// 
			// Label7
			// 
			this->Label7->Location = System::Drawing::Point(62, 88);
			this->Label7->Name = L"Label7";
			this->Label7->Size = System::Drawing::Size(225, 16);
			this->Label7->TabIndex = 5;
			// 
			// Label6
			// 
			this->Label6->Location = System::Drawing::Point(62, 69);
			this->Label6->Name = L"Label6";
			this->Label6->Size = System::Drawing::Size(225, 16);
			this->Label6->TabIndex = 4;
			// 
			// Label5
			// 
			this->Label5->Location = System::Drawing::Point(62, 50);
			this->Label5->Name = L"Label5";
			this->Label5->Size = System::Drawing::Size(225, 16);
			this->Label5->TabIndex = 3;
			// 
			// Label4
			// 
			this->Label4->Location = System::Drawing::Point(62, 31);
			this->Label4->Name = L"Label4";
			this->Label4->Size = System::Drawing::Size(225, 16);
			this->Label4->TabIndex = 2;
			// 
			// Label3
			// 
			this->Label3->Location = System::Drawing::Point(62, 12);
			this->Label3->Name = L"Label3";
			this->Label3->Size = System::Drawing::Size(225, 16);
			this->Label3->TabIndex = 1;
			// 
			// Form1
			// 
			this->AutoScaleDimensions = System::Drawing::SizeF(6, 13);
			this->AutoScaleMode = System::Windows::Forms::AutoScaleMode::Font;
			this->ClientSize = System::Drawing::Size(782, 569);
			this->Controls->Add(this->groupBox1);
			this->Controls->Add(this->groupBox5);
			this->Controls->Add(this->groupBox10);
			this->Controls->Add(this->button18);
			this->Controls->Add(this->button16);
			this->Controls->Add(this->button17);
			this->Controls->Add(this->button5);
			this->Controls->Add(this->callback_text);
			this->Controls->Add(this->groupBox9);
			this->Controls->Add(this->rightvu);
			this->Controls->Add(this->leftvu);
			this->Controls->Add(this->groupBox8);
			this->Controls->Add(this->groupBox7);
			this->Controls->Add(this->button15);
			this->Controls->Add(this->button14);
			this->Controls->Add(this->button13);
			this->Controls->Add(this->button12);
			this->Controls->Add(this->button11);
			this->Controls->Add(this->button10);
			this->Controls->Add(this->button9);
			this->Controls->Add(this->button8);
			this->Controls->Add(this->button7);
			this->Controls->Add(this->button6);
			this->Controls->Add(this->groupBox6);
			this->Controls->Add(this->groupBox4);
			this->Controls->Add(this->groupBox3);
			this->Controls->Add(this->button4);
			this->Controls->Add(this->button3);
			this->Controls->Add(this->button2);
			this->Controls->Add(this->groupBox2);
			this->Controls->Add(this->ProgressBar1);
			this->Controls->Add(this->button1);
			this->Name = L"Form1";
			this->Text = L"libZPlayer player";
			this->Load += gcnew System::EventHandler(this, &Form1::Form1_Load);
			this->FormClosed += gcnew System::Windows::Forms::FormClosedEventHandler(this, &Form1::Form1_FormClosed);
			this->groupBox2->ResumeLayout(false);
			this->groupBox3->ResumeLayout(false);
			this->groupBox4->ResumeLayout(false);
			this->groupBox6->ResumeLayout(false);
			this->groupBox7->ResumeLayout(false);
			this->groupBox8->ResumeLayout(false);
			this->groupBox8->PerformLayout();
			this->groupBox9->ResumeLayout(false);
			this->groupBox9->PerformLayout();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^  >(this->PictureBox1))->EndInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^  >(this->pictureBox2))->EndInit();
			this->groupBox10->ResumeLayout(false);
			this->groupBox10->PerformLayout();
			this->groupBox5->ResumeLayout(false);
			this->groupBox1->ResumeLayout(false);
			this->groupBox1->PerformLayout();
			this->ResumeLayout(false);

		}
#pragma endregion
	private: System::Void Form1_Load(System::Object^  sender, System::EventArgs^  e) {

			ReverseMode = false;
			Echo = false;

	

			int left = 0;
			int right = 0;
			player->GetMasterVolume(left, right);
			leftmastervolume->Value = 100 - left;
			rightmastervolume->Value = 100 - right;
			player->GetPlayerVolume(left, right);
			leftplayervolume->Value = 100 - left;
			rightplayervolume->Value = 100 - right;

			ComboBox1->SelectedIndex = 0;
			ComboBox2->SelectedIndex = 7;
			ComboBox3->SelectedIndex = 11;

			ComboBox4->SelectedIndex = 0;
			ComboBox5->SelectedIndex = 0;

			// callback
			CallbackFunc = gcnew ZPlay::TCallbackFunc(this, &Form1::MyCallbackFunc);
			player->SetCallbackFunc(CallbackFunc, safe_cast<TCallbackMessage>((TCallbackMessage::MsgEnterVolumeSlideAsync | TCallbackMessage::MsgExitVolumeSlideAsync | TCallbackMessage::MsgStreamBufferDoneAsync | TCallbackMessage::MsgNextSong )), 0);

			// echo


			array<TEchoEffect> ^effect = gcnew array<TEchoEffect>(3);

			effect[0].nLeftDelay = 2000;
			effect[0].nLeftSrcVolume = 50;
			effect[0].nLeftEchoVolume = 30;
			effect[0].nRightDelay = 2000;
			effect[0].nRightSrcVolume = 50;
			effect[0].nRightEchoVolume = 30;

			effect[1].nLeftDelay = 30;
			effect[1].nLeftSrcVolume = 50;
			effect[1].nLeftEchoVolume = 30;
			effect[1].nRightDelay = 30;
			effect[1].nRightSrcVolume = 50;
			effect[1].nRightEchoVolume = 30;

			player->SetEchoParam(effect, 2);


		



			array<int> ^EqPoints = gcnew array<int>(9) {100, 200, 300, 1000, 2000, 3000, 5000, 7000, 12000};
			player->SetEqualizerPoints(EqPoints, 9);
			


			if (s->Length != 0)
			{

				player->Close();

				if (LoadMode == 0)
				{
					if (! (player->OpenFile(s, TStreamFormat::sfAutodetect)))
					{
						MessageBox::Show(player->GetError(), System::String::Empty, MessageBoxButtons::OK, MessageBoxIcon::Error);
					}
				}

				showinfo();
			}

			
	
			 }
	private: System::Void button1_Click(System::Object^  sender, System::EventArgs^  e) {
				 LoadMode = 0;
				OpenFileDialog1->ShowDialog();
			 }
	private: System::Void openFileDialog1_FileOk(System::Object^  sender, System::ComponentModel::CancelEventArgs^  e) {

				

			TStreamFormat format = player->GetFileFormat(OpenFileDialog1->FileName);
			

			if (LoadMode == 0)
			{
				player->Close();
				if (! (player->OpenFile(OpenFileDialog1->FileName,  TStreamFormat::sfAutodetect)))
				{
					MessageBox::Show(player->GetError(), System::String::Empty, MessageBoxButtons::OK, MessageBoxIcon::Error);
					return;
				}
			}
			else if (LoadMode == 1)
			{
				player->Close();
				FileInfo ^fInfo = gcnew FileInfo(OpenFileDialog1->FileName);
				long numBytes = (long) fInfo->Length;
				FileStream ^fStream = gcnew FileStream(OpenFileDialog1->FileName, FileMode::Open, FileAccess::Read);
				BinaryReader ^br = gcnew BinaryReader(fStream);
				array<System::Byte> ^stream_data = nullptr;

				stream_data = br->ReadBytes((int)numBytes);
				if (! (player->OpenStream(true, false,  stream_data, (unsigned int) numBytes, format)))
				{
					MessageBox::Show(player->GetError(), "Fatal error", MessageBoxButtons::OK, MessageBoxIcon::Error);
					
				}

				br->Close();
				fStream->Close();
			}
			
			else if (LoadMode == 2)
			{
				player->Close();
				BufferCounter = 0;

				FileInfo ^fInfo = gcnew FileInfo(OpenFileDialog1->FileName);
				unsigned int numBytes = (unsigned int) fInfo->Length;
				if (br != nullptr)
				{
					br->Close();
				}
				if (fStream != nullptr)
				{
					fStream->Close();
				}

				br = nullptr;
				fStream = nullptr;

				fStream = gcnew FileStream(OpenFileDialog1->FileName, FileMode::Open, FileAccess::Read);
				br = gcnew BinaryReader(fStream);
				array<System::Byte> ^stream_data = nullptr;
				unsigned int small_chunk = 0;
				small_chunk = (unsigned int) Math::Min((unsigned int) 100000, (unsigned int) numBytes);
				// read small chunk of data
				stream_data = br->ReadBytes(small_chunk);
				// open stream
				if (! (player->OpenStream(true, true, stream_data, stream_data->Length, format)))
				{
					MessageBox::Show(player->GetError(), "Fatal error", MessageBoxButtons::OK, MessageBoxIcon::Error);
					
				}

				// read more data and push into stream
				stream_data = br->ReadBytes(small_chunk);
				player->PushDataToStream(stream_data, stream_data->Length);
			}
			else if (LoadMode == 3)
			{
				if (! (player->AddFile(OpenFileDialog1->FileName,  TStreamFormat::sfAutodetect)))
				{
					MessageBox::Show(player->GetError(), System::String::Empty, MessageBoxButtons::OK, MessageBoxIcon::Error);
					return;
				}


			}

			
			showinfo();



		}
	private: System::Void Timer1_Tick(System::Object^  sender, System::EventArgs^  e) {

		
			TStreamTime pos;
			player->GetPosition(pos);
			if(ProgressBar1->Maximum > pos.sec)
				ProgressBar1->Value = System::Convert::ToInt32(safe_cast<int>(pos.sec));


			
			position->Text = System::String::Format("{0,2:G}", pos.hms.hour) + " : " + System::String::Format("{0,2:G}", pos.hms.minute) + " : " + System::String::Format("{0,2:G}", pos.hms.second) + " : " + System::String::Format("{0,3:G}", pos.hms.millisecond);
          

			TStreamStatus Status;
			player->GetStatus(Status);

			statuslabel1->Text = "Eq:" + System::Environment::NewLine + "Fade:" + System::Environment::NewLine + "Echo:" + System::Environment::NewLine + "Bitrate:" + System::Environment::NewLine + "Vocal cut:" + System::Environment::NewLine + "Side cut:";

			statuslabel2->Text = "Loop:" + System::Environment::NewLine + "Reverse:" + System::Environment::NewLine + "Play:" + System::Environment::NewLine + "Pause:" + System::Environment::NewLine + "Channel mix:" + System::Environment::NewLine + "Load:";

			statusvalue1->Text = System::Convert::ToString(Status.fEqualizer) + System::Environment::NewLine + System::Convert::ToString(Status.fSlideVolume) + System::Environment::NewLine + System::Convert::ToString(Status.fEcho) + System::Environment::NewLine + System::Convert::ToString(player->GetBitrate(0)) + System::Environment::NewLine + System::Convert::ToString(Status.fVocalCut) + System::Environment::NewLine + System::Convert::ToString(Status.fSideCut);

			TStreamLoadInfo load;
			player->GetDynamicStreamLoad(load);
			statusvalue2->Text = System::Convert::ToString(Status.nLoop) + System::Environment::NewLine + System::Convert::ToString(Status.fReverse) + System::Environment::NewLine + System::Convert::ToString(Status.fPlay) + System::Environment::NewLine + System::Convert::ToString(Status.fPause) + System::Environment::NewLine + System::Convert::ToString(Status.fChannelMix) + System::Environment::NewLine + System::Convert::ToString(load.NumberOfBuffers);

			if (Status.fSlideVolume != false)
			{
				int left;
				int right;
				player->GetPlayerVolume(left, right);
				leftplayervolume->Value = 100 - left;
				rightplayervolume->Value = 100 - right;
			}

			if (FadeFinished)
			{
				int left;
				int right;
				player->GetPlayerVolume(left, right);
				leftplayervolume->Value = 100 - left;
				rightplayervolume->Value = 100 - right;
				FadeFinished = false;
			}


			if(NextSong)
            {
                showinfo();
                NextSong = false;
            }

			
			 }
private: System::Void button2_Click(System::Object^  sender, System::EventArgs^  e) {
			 player->StartPlayback();
		 }
private: System::Void button5_Click(System::Object^  sender, System::EventArgs^  e) {
			 player->StopPlayback();
		 }
private: System::Void button4_Click(System::Object^  sender, System::EventArgs^  e) {
			 player->PausePlayback();
		 }
private: System::Void button3_Click(System::Object^  sender, System::EventArgs^  e) {
			 player->ResumePlayback();
		 }
private: System::Void leftplayervolume_Scroll(System::Object^  sender, System::Windows::Forms::ScrollEventArgs^  e) {
			int left;
			int right;
			player->GetPlayerVolume(left, right);
			player->SetPlayerVolume(100 - (safe_cast<VScrollBar^>(sender))->Value, right);
		 }
private: System::Void rightplayervolume_Scroll(System::Object^  sender, System::Windows::Forms::ScrollEventArgs^  e) {
			 int left;
			int right;
			player->GetPlayerVolume(left, right);
			 player->SetPlayerVolume(left, 100 - (safe_cast<VScrollBar^>(sender))->Value);
		 }
private: System::Void leftmastervolume_Scroll(System::Object^  sender, System::Windows::Forms::ScrollEventArgs^  e) {
			 int left;
				int right;
				player->GetMasterVolume(left, right);
			 player->SetMasterVolume(100 - (safe_cast<VScrollBar^>(sender))->Value, right);
		 }
private: System::Void rightmastervolume_Scroll(System::Object^  sender, System::Windows::Forms::ScrollEventArgs^  e) {
			 int left;
				int right;
				player->GetMasterVolume(left, right);
			 player->SetMasterVolume(left,  100 - (safe_cast<VScrollBar^>(sender))->Value);
		 }
private: System::Void button13_Click(System::Object^  sender, System::EventArgs^  e) {
			 TStreamTime newpos = TStreamTime();
			newpos.sec = 5;
			player->Seek(TTimeFormat::tfSecond, newpos, TSeekMethod::smFromCurrentBackward);
		 }
private: System::Void button12_Click(System::Object^  sender, System::EventArgs^  e) {
			 TStreamTime newpos = TStreamTime();
			newpos.sec = 5;
			player->Seek(TTimeFormat::tfSecond, newpos, TSeekMethod::smFromCurrentForward);
		 }
private: System::Void button11_Click(System::Object^  sender, System::EventArgs^  e) {
			 TStreamTime startpos = TStreamTime();
			TStreamTime endpos = TStreamTime();
			player->GetPosition(startpos);
			endpos.sec = System::Convert::ToUInt32(startpos.sec + 2);
			player->PlayLoop(TTimeFormat::tfSecond, startpos, TTimeFormat::tfSecond, endpos, 3, 1);
		 }
private: System::Void button10_Click(System::Object^  sender, System::EventArgs^  e) {
			 
			Echo = ! Echo;
			player->EnableEcho(Echo);
		 }
private: System::Void button9_Click(System::Object^  sender, System::EventArgs^  e) {
			 int left = 0;
			int right = 0;
			TStreamTime startpos = TStreamTime();
			TStreamTime endpos = TStreamTime();

			player->GetPlayerVolume(left, right);
			player->GetPosition(startpos);
			endpos.sec = System::Convert::ToUInt32(startpos.sec + 5);
			player->SlideVolume(TTimeFormat::tfSecond, startpos, left, right, TTimeFormat::tfSecond, endpos, 100, 100);
		 }
private: System::Void button8_Click(System::Object^  sender, System::EventArgs^  e) {
			 int left = 0;
			int right = 0;
			TStreamTime startpos = TStreamTime();
			TStreamTime endpos = TStreamTime();

			player->GetPlayerVolume(left, right);
			player->GetPosition(startpos);
			endpos.sec = System::Convert::ToUInt32(startpos.sec + 5);
			player->SlideVolume(TTimeFormat::tfSecond, startpos, left, right, TTimeFormat::tfSecond, endpos, 0, 0);
		 }
private: System::Void button7_Click(System::Object^  sender, System::EventArgs^  e) {
			 SideCut = false;
			VocalCut = ! VocalCut;
			player->StereoCut(VocalCut | SideCut, SideCut, true);
		 }
private: System::Void button6_Click(System::Object^  sender, System::EventArgs^  e) {
			 
			SideCut = ! SideCut;
			VocalCut = false;
			player->StereoCut(VocalCut | SideCut, SideCut, false);
		 }

private: System::Void ProgressBar1_MouseClick(System::Object^  sender, System::Windows::Forms::MouseEventArgs^  e) {
			TStreamTime newpos = TStreamTime();
			TStreamInfo StreamInfo;
			player->GetStreamInfo(StreamInfo);

			newpos.sec = System::Convert::ToUInt32(e->X * StreamInfo.Length.sec / System::Convert::ToDouble((safe_cast<ProgressBar^>(sender))->Size.Width));
			player->Seek(TTimeFormat::tfSecond, newpos, TSeekMethod::smFromBeginning);
		 }
private: System::Void button15_Click(System::Object^  sender, System::EventArgs^  e) {
			 ReverseMode = ! ReverseMode;
			 player->ReverseMode(ReverseMode);
		 }
private: System::Void button14_Click(System::Object^  sender, System::EventArgs^  e) {
			if (MessageBox::Show("This can take some time! Continue ?", "Detecting BPM", MessageBoxButtons::YesNoCancel) == System::Windows::Forms::DialogResult::Yes)
			{
				int BPM = 0;
				BPM = player->DetectBPM(TBPMDetectionMethod::dmPeaks);
				MessageBox::Show("BPM: " + System::Convert::ToString(BPM), "Detected BPM", MessageBoxButtons::OK);
			}
		 }
private: System::Void vScrollBar1_Scroll(System::Object^  sender, System::Windows::Forms::ScrollEventArgs^  e) {
			 if (player != nullptr)
			{
				player->SetPitch(200 - (safe_cast<VScrollBar^>(sender))->Value);
			}
		 }
private: System::Void vScrollBar2_Scroll(System::Object^  sender, System::Windows::Forms::ScrollEventArgs^  e) {
			 if (player != nullptr)
			{
				player->SetTempo(200 - (safe_cast<VScrollBar^>(sender))->Value);
			}
		 }
private: System::Void vScrollBar3_Scroll(System::Object^  sender, System::Windows::Forms::ScrollEventArgs^  e) {
			 if (player != nullptr)
			{
				player->SetRate(200 - (safe_cast<VScrollBar^>(sender))->Value);
			}
		 }
private: System::Void vScrollBar4_Scroll(System::Object^  sender, System::Windows::Forms::ScrollEventArgs^  e) {
			 if (player != nullptr)
			{
				player->SetEqualizerPreampGain(20000 - (safe_cast<VScrollBar^>(sender))->Value * 1000);
			}
		 }
private: System::Void vScrollBar14_Scroll(System::Object^  sender, System::Windows::Forms::ScrollEventArgs^  e) {
			 if (player != nullptr)
			{
				player->SetEqualizerBandGain(0, 20000 - (safe_cast<VScrollBar^>(sender))->Value * 1000);
			}
		 }
private: System::Void vScrollBar13_Scroll(System::Object^  sender, System::Windows::Forms::ScrollEventArgs^  e) {
			 if (player != nullptr)
			{
				player->SetEqualizerBandGain(2, 20000 - (safe_cast<VScrollBar^>(sender))->Value * 1000);
			}
		 }
private: System::Void vScrollBar12_Scroll(System::Object^  sender, System::Windows::Forms::ScrollEventArgs^  e) {
			 if (player != nullptr)
			{
				player->SetEqualizerBandGain(3, 20000 - (safe_cast<VScrollBar^>(sender))->Value * 1000);
			}
		 }
private: System::Void vScrollBar6_Scroll(System::Object^  sender, System::Windows::Forms::ScrollEventArgs^  e) {
			 if (player != nullptr)
			{
				player->SetEqualizerBandGain(4, 20000 - (safe_cast<VScrollBar^>(sender))->Value * 1000);
			}
		 }
private: System::Void vScrollBar5_Scroll(System::Object^  sender, System::Windows::Forms::ScrollEventArgs^  e) {
			 if (player != nullptr)
			{
				player->SetEqualizerBandGain(5, 20000 - (safe_cast<VScrollBar^>(sender))->Value * 1000);
			}
		 }
private: System::Void vScrollBar7_Scroll(System::Object^  sender, System::Windows::Forms::ScrollEventArgs^  e) {
			 if (player != nullptr)
			{
				player->SetEqualizerBandGain(6, 20000 - (safe_cast<VScrollBar^>(sender))->Value * 1000);
			}
		 }
private: System::Void vScrollBar8_Scroll(System::Object^  sender, System::Windows::Forms::ScrollEventArgs^  e) {
			 if (player != nullptr)
			{
				player->SetEqualizerBandGain(7, 20000 - (safe_cast<VScrollBar^>(sender))->Value * 1000);
			}
		 }
private: System::Void vScrollBar9_Scroll(System::Object^  sender, System::Windows::Forms::ScrollEventArgs^  e) {
			 if (player != nullptr)
			{
				player->SetEqualizerBandGain(8, 20000 - (safe_cast<VScrollBar^>(sender))->Value * 1000);
			}
		 }
private: System::Void vScrollBar11_Scroll(System::Object^  sender, System::Windows::Forms::ScrollEventArgs^  e) {
			 if (player != nullptr)
			{
				player->SetEqualizerBandGain(9, 20000 - (safe_cast<VScrollBar^>(sender))->Value * 1000);
			}
		 }
private: System::Void checkBox1_CheckedChanged(System::Object^  sender, System::EventArgs^  e) {
			 player->EnableEqualizer((safe_cast<CheckBox^>(sender))->Checked);
		 }
private: System::Void Timer2_Tick(System::Object^  sender, System::EventArgs^  e) {

			int left = 0;
			int right = 0;

			if (FFTEnabled->Checked)
			{
				PictureBox1->Refresh();
			}

			 player->GetVUData(left, right);
			leftvu->Value = left;
			rightvu->Value = right;
		 }
private: System::Void checkBox3_CheckedChanged(System::Object^  sender, System::EventArgs^  e) {
			 if (player != nullptr)
			{
				if ((safe_cast<CheckBox^>(sender))->Checked)
				{
					player->SetFFTGraphParam(TFFTGraphParamID::gpHorizontalScale,  (int) TFFTGraphHorizontalScale::gsLinear);
				}
				else
				{
					player->SetFFTGraphParam(TFFTGraphParamID::gpHorizontalScale,  (int) TFFTGraphHorizontalScale::gsLogarithmic);
				}
			}
		 }
private: System::Void checkBox4_CheckedChanged(System::Object^  sender, System::EventArgs^  e) {
			 if (player != nullptr)
			{
				if ((safe_cast<CheckBox^>(sender))->Checked)
				{
					player->SetFFTGraphParam(TFFTGraphParamID::gpFrequencyGridVisible,  1);
					player->SetFFTGraphParam(TFFTGraphParamID::gpDecibelGridVisible,  1);
				}
				else
				{
					player->SetFFTGraphParam(TFFTGraphParamID::gpFrequencyGridVisible,  0);
					player->SetFFTGraphParam(TFFTGraphParamID::gpDecibelGridVisible,  0);
				}
			}
		 }
private: System::Void ComboBox1_SelectedIndexChanged(System::Object^  sender, System::EventArgs^  e) {
			 if (player != nullptr)
			{
				player->SetFFTGraphParam(TFFTGraphParamID::gpGraphType,  (safe_cast<ComboBox^>(sender))->SelectedIndex);

			}
		 }
private: System::Void ComboBox3_SelectedIndexChanged(System::Object^  sender, System::EventArgs^  e) {
			 if (player != nullptr)
			{
				player->SetFFTGraphParam(TFFTGraphParamID::gpWindow,  (safe_cast<ComboBox^>(sender))->SelectedIndex + 1);

			}
		 }
private: System::Void ComboBox2_SelectedIndexChanged(System::Object^  sender, System::EventArgs^  e) {
			 int points = 0;
			points = System::Convert::ToInt32(Math::Pow(2, (safe_cast<ComboBox^>(sender))->SelectedIndex + 2));
			if (player != nullptr)
			{
				player->SetFFTGraphParam(TFFTGraphParamID::gpFFTPoints,  points);

			}
		 }
private: System::Void pictureBox1_Paint(System::Object^  sender, System::Windows::Forms::PaintEventArgs^  e) {
			
			IntPtr MyDeviceContext = e->Graphics->GetHdc();
			player->DrawFFTGraphOnHDC(MyDeviceContext, 0, 0, PictureBox1->Width, PictureBox1->Height);
			e->Graphics->ReleaseHdc(MyDeviceContext);
		 }
private: System::Void Form1_FormClosed(System::Object^  sender, System::Windows::Forms::FormClosedEventArgs^  e) {
			 
			if (br != nullptr)
			{
				br->Close();
			}
			if (fStream != nullptr)
			{
				fStream->Close();
			}
		 }
private: System::Void button16_Click(System::Object^  sender, System::EventArgs^  e) {
			 LoadMode = 1;
			OpenFileDialog1->ShowDialog();
		 }
private: System::Void button17_Click(System::Object^  sender, System::EventArgs^  e) {
			 LoadMode = 2;
			OpenFileDialog1->ShowDialog();
		 }
private: System::Void callback_text_Click(System::Object^  sender, System::EventArgs^  e) {
		 }
private: System::Void button18_Click(System::Object^  sender, System::EventArgs^  e) {
			 LoadMode = 3;
			OpenFileDialog1->ShowDialog();
		 }
private: System::Void checkBox2_CheckedChanged(System::Object^  sender, System::EventArgs^  e) {
			 if (player != nullptr)
			{
				if ((safe_cast<CheckBox^>(sender))->Checked)
				{
					player->SetFFTGraphParam(TFFTGraphParamID::gpFrequencyScaleVisible,  1);
					player->SetFFTGraphParam(TFFTGraphParamID::gpDecibelScaleVisible,  1);
				}
				else
				{
					player->SetFFTGraphParam(TFFTGraphParamID::gpFrequencyScaleVisible,  0);
					player->SetFFTGraphParam(TFFTGraphParamID::gpDecibelScaleVisible,  0);
				}
			}
		 }
private: System::Void button19_Click(System::Object^  sender, System::EventArgs^  e) {
			 player->Close();
			 if (! (player->OpenFile("wavein://src=line;volume=50",  TStreamFormat::sfAutodetect)))
				{
					MessageBox::Show(player->GetError(), System::String::Empty, MessageBoxButtons::OK, MessageBoxIcon::Error);
					return;
				}

				showinfo();
				player->StartPlayback();


		 }
private: System::Void button20_Click(System::Object^  sender, System::EventArgs^  e) {
			  player->Close();
			 if (! (player->OpenFile("wavein://src=microphone;volume=50",  TStreamFormat::sfAutodetect)))
				{
					MessageBox::Show(player->GetError(), System::String::Empty, MessageBoxButtons::OK, MessageBoxIcon::Error);
					return;
				}

				showinfo();
				player->StartPlayback();
		 }
private: System::Void button21_Click(System::Object^  sender, System::EventArgs^  e) {
			 LoadMode = 0;
			saveFileDialog1->ShowDialog();
		 }
private: System::Void button22_Click(System::Object^  sender, System::EventArgs^  e) {
			 LoadMode = 1;
			saveFileDialog1->ShowDialog();
		 }
private: System::Void saveFileDialog1_FileOk(System::Object^  sender, System::ComponentModel::CancelEventArgs^  e) {

			

			 switch (ComboBox5->SelectedIndex)
			{
				case 1:
					player->SetWaveOutFile((safe_cast<SaveFileDialog^>(sender))->FileName, TStreamFormat::sfMp3, CheckBox3->Checked);
					break;
				case 2:
					player->SetWaveOutFile((safe_cast<SaveFileDialog^>(sender))->FileName, TStreamFormat::sfOgg, CheckBox3->Checked);
					break;
				case 3:
					player->SetWaveOutFile((safe_cast<SaveFileDialog^>(sender))->FileName, TStreamFormat::sfFLAC, CheckBox3->Checked);
					break;
				case 4:
					player->SetWaveOutFile((safe_cast<SaveFileDialog^>(sender))->FileName, TStreamFormat::sfFLACOgg, CheckBox3->Checked);
					break;
				case 5:
					player->SetWaveOutFile((safe_cast<SaveFileDialog^>(sender))->FileName, TStreamFormat::sfAacADTS, CheckBox3->Checked);
					break;
				case 6:
					player->SetWaveOutFile((safe_cast<SaveFileDialog^>(sender))->FileName, TStreamFormat::sfWav, CheckBox3->Checked);
					break;
				case 7:
					player->SetWaveOutFile((safe_cast<SaveFileDialog^>(sender))->FileName, TStreamFormat::sfPCM, CheckBox3->Checked);
					break;
			}


			showinfo();
			player->StartPlayback();

		 }
private: System::Void Button20_Click_1(System::Object^  sender, System::EventArgs^  e) {

			 //INSTANT C++ TODO TASK: There is no equivalent to implicit typing in C++:
			String ^file = "wavein://";

			switch (ComboBox4->SelectedIndex)
			{
				case 0:
					file = "wavein://src=line;volume=50;";
					break;
				case 1:
					file = "wavein://src=mic;volume=50;";
					break;
				case 2:
					file = "wavein://src=cd;volume=50;";
					break;
				case 3:
					file = "wavein://src=midi;volume=50;";
					break;
			}
			player->Close();
			if (!(player->OpenFile(file, TStreamFormat::sfAutodetect)))
			{
				MessageBox::Show(player->GetError(), System::String::Empty, MessageBoxButtons::OK, MessageBoxIcon::Error);
				return;
			}

			if (ComboBox5->SelectedIndex > 0)
			{


				switch (ComboBox5->SelectedIndex)
				{
					case 1:
						saveFileDialog1->Filter = "Mp3 File|*.mp3";
						saveFileDialog1->Title = "Save to mp3 file";
						break;
					case 2:
						saveFileDialog1->Filter = "Ogg File|*.ogg";
						saveFileDialog1->Title = "Save to ogg file";
						break;
					case 3:
						saveFileDialog1->Filter = "FLAC File|*.flac";
						saveFileDialog1->Title = "Save to FLAC file";
						break;
					case 4:
						saveFileDialog1->Filter = "FLAC Ogg File|*.oga";
						saveFileDialog1->Title = "Save to FLAC Ogg file";
						break;
					case 5:
						saveFileDialog1->Filter = "AAC File|*.aac";
						saveFileDialog1->Title = "Save to AAC file";
						break;
					case 6:
						saveFileDialog1->Filter = "Wav File|*.wav";
						saveFileDialog1->Title = "Save to Wave file";
						break;
					case 7:
						saveFileDialog1->Filter = "RAW PCM File|*.pcm";
						saveFileDialog1->Title = "Save to pcm file";
						break;
				}

				saveFileDialog1->ShowDialog();
			}
			else
			{
				showinfo();
				player->StartPlayback();

			}
		 }
};
}

