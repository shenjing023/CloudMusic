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
	public partial class Form1
	{
		internal Form1()
		{
			InitializeComponent();
		}
		private ZPlay player;
		private int LoadMode;
		private bool ReverseMode;
		private bool Echo;
		private bool VocalCut = false;
		private bool SideCut = false;
        private bool NextSong = false;

		private bool FadeFinished = false;

        private bool BlockLeft = false;
        private bool BlockRight = false;

		// need this for managed stream
		private System.IO.FileStream fStream = null;
		private System.IO.BinaryReader br = null;
		private int BufferCounter;

		private TCallbackFunc CallbackFunc;

		/// <summary>
		/// Text callback
		/// </summary>
		/// <param name="text"></param>
		/// <remarks></remarks>
		public delegate void SetTextCallback(string text);


		private void SetText(string text)
		{

			// InvokeRequired required compares the thread ID of the
			// calling thread to the thread ID of the creating thread.
			// If these threads are different, it returns true.
			if (this.callback_text.InvokeRequired)
			{
				SetTextCallback d = new SetTextCallback(SetText);
				this.Invoke(d, new object[] {text});
			}
			else
			{
				this.callback_text.Text = text;
			}
		}



		/// <summary>
		/// Show info
		/// </summary>
		/// <remarks></remarks>
        public void showinfo()
        {
           
            Label3.Text = "";
            Label4.Text = "";
            Label5.Text = "";
            Label6.Text = "";
            Label7.Text = "";
            Label8.Text = "";
            Label9.Text = "";

            TID3InfoEx info = new TID3InfoEx();
            if (player.LoadID3Ex(ref info, true))
            {
                 Label3.Text = info.Title;
                Label4.Text = info.Artist;
                Label5.Text = info.Album;
                Label6.Text = info.Year;
                Label7.Text = info.Track;
                Label8.Text = info.Encoder;
                Label9.Text = info.Comment;

            }


            descr.Text = "Format:" + System.Environment.NewLine + "Length:" + System.Environment.NewLine + "Samplerate:" + System.Environment.NewLine + "Bitrate:" + System.Environment.NewLine + "Channel:" + System.Environment.NewLine + "VBR:";

            TStreamInfo StreamInfo = new TStreamInfo();
            player.GetStreamInfo(ref StreamInfo);
            descr1.Text = StreamInfo.Description + System.Environment.NewLine + System.Convert.ToString(StreamInfo.Length.hms.hour) + " : " + System.Convert.ToString(StreamInfo.Length.hms.minute) + " : " + System.Convert.ToString(StreamInfo.Length.hms.second) + System.Environment.NewLine + System.Convert.ToString(StreamInfo.SamplingRate) + " Hz" + System.Environment.NewLine + System.Convert.ToString(StreamInfo.Bitrate) + " kbps" + System.Environment.NewLine + System.Convert.ToString(StreamInfo.ChannelNumber) + System.Environment.NewLine + System.Convert.ToString(StreamInfo.VBR);

            if (info.Picture.PicturePresent)
                pictureBox2.Image = info.Picture.Bitmap;

            ProgressBar1.Minimum = 0;
            ProgressBar1.Maximum = System.Convert.ToInt32((int)(StreamInfo.Length.sec));
            ProgressBar1.Value = 0;
            
            Timer1.Enabled = true;
            Timer2.Enabled = true;

          
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
		public int MyCallbackFunc(uint objptr, int user_data, TCallbackMessage msg, uint param1, uint param2)
		{


			switch (msg)
			{
				case TCallbackMessage.MsgEnterVolumeSlideAsync:
					SetText("EnterFadeAsync");

					break;
				case TCallbackMessage.MsgExitVolumeSlideAsync:
					SetText("ExitFadeAsync");
					FadeFinished = true;

					break;
				case TCallbackMessage.MsgStreamBufferDoneAsync:
					BufferCounter = BufferCounter + 1;
					SetText("StreamBufferDoneAsync: " + System.Convert.ToString(BufferCounter));
					// read more data and push into stream
					byte[] stream_data = null;
					int small_chunk = 100000;
					stream_data = br.ReadBytes(small_chunk);
					if (stream_data.Length > 0)
					{
						player.PushDataToStream(ref stream_data, System.Convert.ToUInt32(stream_data.Length));
					}
					else
					{
						byte[] tempMemNewData1 = null;
						player.PushDataToStream(ref tempMemNewData1, 0);
					}
					break;


                case TCallbackMessage.MsgNextSongAsync:
                    {
                        SetText("MsgNextSongAsync: " + System.Convert.ToString(param1));
                        NextSong = true;

                    }
                    break;
			}

			return 0;
		}


		private void Form1_Load(object sender, System.EventArgs e)
		{
			player = new ZPlay();
			ReverseMode = false;
			Echo = false;

			int left = 0;
			int right = 0;
			player.GetMasterVolume(ref left, ref right);
			leftmastervolume.Value = 100 - left;
			rightmastervolume.Value = 100 - right;
			player.GetPlayerVolume(ref left, ref right);
			leftplayervolume.Value = 100 - left;
			rightplayervolume.Value = 100 - right;

			// callback
			CallbackFunc = new TCallbackFunc(MyCallbackFunc);
            player.SetCallbackFunc(CallbackFunc, (TCallbackMessage)((TCallbackMessage.MsgEnterVolumeSlideAsync | TCallbackMessage.MsgExitVolumeSlideAsync | TCallbackMessage.MsgStreamBufferDoneAsync | TCallbackMessage.MsgNextSongAsync )), 0);

         
			// echo

            
			TEchoEffect[] effect = new TEchoEffect[2];

			effect[0].nLeftDelay = 500;
			effect[0].nLeftSrcVolume = 50;
			effect[0].nLeftEchoVolume = 30;
			effect[0].nRightDelay = 500;
			effect[0].nRightSrcVolume = 50;
			effect[0].nRightEchoVolume = 30;

			effect[1].nLeftDelay = 30;
			effect[1].nLeftSrcVolume = 50;
			effect[1].nLeftEchoVolume = 30;
			effect[1].nRightDelay = 30;
			effect[1].nRightSrcVolume = 50;
			effect[1].nRightEchoVolume = 30;

            player.SetEchoParam(ref effect, 2);
  
            
            /*
            TEchoEffect[] test1 = new TEchoEffect[2];
            int n = player.GetEchoParam(ref test1);
            int i;
            for (i = 0; i < n; i++)
            {
                MessageBox.Show(test1[i].nLeftDelay.ToString());
            }
            */

            /*
            int[] EqPoints = new int[9] { 100, 200, 300, 1000, 2000, 3000, 5000, 7000, 12000 };
            player.SetEqualizerPoints(ref EqPoints, 9);
            */

            /*
            int[] testeq = new int[1];
            int num = player.GetEqualizerPoints(ref testeq);
            int i1;
            for (i1 = 0; i1 < num; i1++)
            {
                MessageBox.Show(testeq[i1].ToString ());

            }
             */
            

            /*
            TWaveOutInfo WaveOutInfo = new TWaveOutInfo();
            int WaveOutNum = player.EnumerateWaveOut();
            uint i;
            for (i = 0; i < WaveOutNum; i++)
            {
                if (player.GetWaveOutInfo(i, ref WaveOutInfo))
                {
                    MessageBox.Show(WaveOutInfo.ProductName );

                }
            }
            
            */


			ComboBox1.SelectedIndex = 0;
			ComboBox2.SelectedIndex = 7;
			ComboBox3.SelectedIndex = 11;

            ComboBox4.SelectedIndex = 0;
            ComboBox5.SelectedIndex = 0;

			if (My.MyApplication.Application.CommandLineArgs.Count != 0)
			{

				player.Close();

				if (LoadMode == 0)
				{
                    if (!(player.OpenFile(My.MyApplication.Application.CommandLineArgs[0], TStreamFormat.sfAutodetect)))
					{
						MessageBox.Show(player.GetError(), string.Empty, MessageBoxButtons.OK, MessageBoxIcon.Error);
					}
				}

				showinfo();
                player.StartPlayback();
			}

		}

		private void Form1_FormClosed(object sender, System.Windows.Forms.FormClosedEventArgs e)
		{

			if (br != null)
			{
				br.Close();
			}
			if (fStream != null)
			{
				fStream.Close();
			}
		}

		private void Button1_Click(object sender, System.EventArgs e)
		{
			LoadMode = 0;
			OpenFileDialog1.ShowDialog();
		}

		private void OpenFileDialog1_FileOk(object sender, System.ComponentModel.CancelEventArgs e)
		{

			
            
			TStreamFormat format = player.GetFileFormat(OpenFileDialog1.FileName);
   
			if (LoadMode == 0)
			{
                player.Close();
				if (! (player.OpenFile(OpenFileDialog1.FileName, TStreamFormat.sfAutodetect )))
				{
					MessageBox.Show(player.GetError(), string.Empty, MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
				}
			}
			else if (LoadMode == 1)
			{
                player.Close();
				System.IO.FileInfo fInfo = new System.IO.FileInfo(OpenFileDialog1.FileName);
				long numBytes = fInfo.Length;
				System.IO.FileStream fStream = new System.IO.FileStream(OpenFileDialog1.FileName, System.IO.FileMode.Open, System.IO.FileAccess.Read);
				System.IO.BinaryReader br = new System.IO.BinaryReader(fStream);
				byte[] stream_data = null;

				stream_data = br.ReadBytes(System.Convert.ToInt32((int)(numBytes)));
                if (!(player.OpenStream(true, false, ref stream_data, System.Convert.ToUInt32(numBytes), format)))
				{
					MessageBox.Show(player.GetError(), string.Empty, MessageBoxButtons.OK, MessageBoxIcon.Error);
				}

				br.Close();
				fStream.Close();
			}
			else if (LoadMode == 2)
			{
                player.Close();
				BufferCounter = 0;

				System.IO.FileInfo fInfo = new System.IO.FileInfo(OpenFileDialog1.FileName);
				uint numBytes = System.Convert.ToUInt32(fInfo.Length);
				if (br != null)
				{
					br.Close();
				}
				if (fStream != null)
				{
					fStream.Close();
				}

				br = null;
				fStream = null;

				fStream = new System.IO.FileStream(OpenFileDialog1.FileName, System.IO.FileMode.Open, System.IO.FileAccess.Read);
				br = new System.IO.BinaryReader(fStream);
				byte[] stream_data = null;
				uint small_chunk = 0;
				small_chunk = System.Convert.ToUInt32(Math.Min(100000, numBytes));
				// read small chunk of data
				stream_data = br.ReadBytes(System.Convert.ToInt32((int)(small_chunk)));
				// open stream
				if (! (player.OpenStream(true, true, ref stream_data, System.Convert.ToUInt32(stream_data.Length), format)))
				{
					MessageBox.Show(player.GetError(), string.Empty, MessageBoxButtons.OK, MessageBoxIcon.Error);
				}

				// read more data and push into stream
				stream_data = br.ReadBytes(System.Convert.ToInt32((int)(small_chunk)));
				player.PushDataToStream(ref stream_data, System.Convert.ToUInt32(stream_data.Length));
			}
            else if (LoadMode == 3)
            {
                if (!(player.AddFile(OpenFileDialog1.FileName, TStreamFormat.sfAutodetect)))
                {
                    MessageBox.Show(player.GetError(), string.Empty, MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                }


            }

			showinfo();
            player.StartPlayback();

		}

		private void Button2_Click(object sender, System.EventArgs e)
		{
            player.StartPlayback();
		}

		private void Button3_Click(object sender, System.EventArgs e)
		{
            player.PausePlayback();

		}

		private void Button4_Click(object sender, System.EventArgs e)
		{
            player.ResumePlayback();
		}

		private void Button5_Click(object sender, System.EventArgs e)
		{
			player.StopPlayback();
		}

		private void Button6_Click(object sender, System.EventArgs e)
		{
			LoadMode = 1;
			OpenFileDialog1.ShowDialog();
		}

		private void Button7_Click(object sender, System.EventArgs e)
		{
			LoadMode = 2;
			OpenFileDialog1.ShowDialog();
		}

		private void Timer1_Tick(object sender, System.EventArgs e)
		{
            TStreamTime pos = new TStreamTime();

            player.GetPosition(ref pos);

            if(ProgressBar1.Maximum > pos.sec)
			    ProgressBar1.Value = System.Convert.ToInt32((int)(pos.sec));


		
            position.Text = System.String.Format("{0,2:G}", pos.hms.hour) + " : " + System.String.Format("{0,2:G}", pos.hms.minute) + " : " + System.String.Format("{0,2:G}", pos.hms.second) + " : " + System.String.Format("{0,3:G}", pos.hms.millisecond);
          

			TStreamStatus Status = new TStreamStatus();
			player.GetStatus(ref Status);

			statuslabel1.Text = "Eq:" + System.Environment.NewLine + "Fade:" + System.Environment.NewLine + "Echo:" + System.Environment.NewLine + "Bitrate:" + System.Environment.NewLine + "Vocal cut:" + System.Environment.NewLine + "Side cut:";

			statuslabel2.Text = "Loop:" + System.Environment.NewLine + "Reverse:" + System.Environment.NewLine + "Play:" + System.Environment.NewLine + "Pause:" + System.Environment.NewLine + "Channel mix:" + System.Environment.NewLine + "Load:";

			statusvalue1.Text = System.Convert.ToString(Status.fEqualizer) + System.Environment.NewLine + System.Convert.ToString(Status.fSlideVolume) + System.Environment.NewLine + System.Convert.ToString(Status.fEcho) + System.Environment.NewLine + System.Convert.ToString(player.GetBitrate(false)) + System.Environment.NewLine + System.Convert.ToString(Status.fVocalCut) + System.Environment.NewLine + System.Convert.ToString(Status.fSideCut);

			TStreamLoadInfo load = new TStreamLoadInfo();
			player.GetDynamicStreamLoad(ref load);
			statusvalue2.Text = System.Convert.ToString(Status.nLoop) + System.Environment.NewLine + System.Convert.ToString(Status.fReverse) + System.Environment.NewLine + System.Convert.ToString(Status.fPlay) + System.Environment.NewLine + System.Convert.ToString(Status.fPause) + System.Environment.NewLine + System.Convert.ToString(Status.fChannelMix) + System.Environment.NewLine + System.Convert.ToString(load.NumberOfBuffers);
            
			if (Status.fSlideVolume != false)
			{
                BlockLeft = true;
                BlockRight = true;

                int Left = 0;
                int Right = 0;
                player.GetPlayerVolume(ref Left, ref Right);

				leftplayervolume.Value = 100 - Left;
				rightplayervolume.Value = 100 - Right;
                
			}
            
			if (FadeFinished)
			{
                int Left = 0;
                int Right = 0;
                player.GetPlayerVolume(ref Left, ref Right);

                leftplayervolume.Value = 100 - Left;
                rightplayervolume.Value = 100 - Right;
				FadeFinished = false;
			}
            

            if(NextSong)
            {
                showinfo();
                NextSong = false;
            }
       


		}

		private void ProgressBar1_MouseClick(object sender, System.Windows.Forms.MouseEventArgs e)
		{
			TStreamTime newpos = new TStreamTime();

            TStreamInfo Info = new TStreamInfo();
            player.GetStreamInfo(ref Info);

			newpos.sec = System.Convert.ToUInt32(e.X * Info.Length.sec / System.Convert.ToDouble(((ProgressBar)sender).Size.Width));
            player.Seek(TTimeFormat.tfSecond, ref newpos, TSeekMethod.smFromBeginning);
			


		}

		private void Button9_Click(object sender, System.EventArgs e)
		{
			TStreamTime newpos = new TStreamTime();
			newpos.sec = 5;
			player.Seek(TTimeFormat.tfSecond, ref newpos, TSeekMethod.smFromCurrentBackward);
		}

		private void Button10_Click(object sender, System.EventArgs e)
		{
			TStreamTime newpos = new TStreamTime();
			newpos.sec = 5;
			player.Seek(TTimeFormat.tfSecond, ref newpos, TSeekMethod.smFromCurrentForward);
		}

		private void Button11_Click(object sender, System.EventArgs e)
		{
			TStreamTime startpos = new TStreamTime();
			TStreamTime endpos = new TStreamTime();
			player.GetPosition(ref startpos);
			endpos.sec = System.Convert.ToUInt32(startpos.sec + 2);
			player.PlayLoop(TTimeFormat.tfSecond, ref startpos, TTimeFormat.tfSecond, ref endpos, 3, true);

		}

		private void Button12_Click(object sender, System.EventArgs e)
		{
			ReverseMode = ! ReverseMode;
            player.ReverseMode(ReverseMode);

		}

		private void leftmastervolume_ValueChanged(object sender, System.EventArgs e)
		{
			player.SetMasterVolume( 100 - ((VScrollBar)sender).Value, 100 - rightmastervolume.Value);
		}

		private void rightmastervolume_ValueChanged(object sender, System.EventArgs e)
		{
			player.SetMasterVolume(100 - leftmastervolume.Value,  100 - ((VScrollBar)sender).Value); 
		}

		private void leftplayervolume_ValueChanged(object sender, System.EventArgs e)
		{
            if(BlockLeft == false)
			    player.SetPlayerVolume(100 - ((VScrollBar)sender).Value, 100 - rightplayervolume.Value);

            BlockLeft = false;
		}

		private void rightplayervolume_ValueChanged(object sender, System.EventArgs e)
		{
            if(BlockRight == false)
			    player.SetPlayerVolume(100 - leftplayervolume.Value, 100 - ((VScrollBar)sender).Value);

            BlockRight = false;
		}

		private void Timer2_Tick(object sender, System.EventArgs e)
		{
			int left = 0;
			int right = 0;

			if (FFTEnabled.Checked)
			{
				PictureBox1.Refresh();
			}

			//Dim leftamplitude(512) As Integer
			//player.GetFFTValues(1024, ZPlay.TFFTWindow.fwBartlett, Nothing, Nothing, leftamplitude, Nothing, Nothing, Nothing)
			//leftvu.Value = leftamplitude(1)

			player.GetVUData(ref left, ref right);
			leftvu.Value = left;
			rightvu.Value = right;

		}

		private void Button13_Click(object sender, System.EventArgs e)
		{
			int left = 0;
			int right = 0;
			TStreamTime startpos = new TStreamTime();
			TStreamTime endpos = new TStreamTime();

			player.GetPlayerVolume(ref left, ref right);
			player.GetPosition(ref startpos);
			endpos.sec = System.Convert.ToUInt32(startpos.sec + 5);
			player.SlideVolume(TTimeFormat.tfSecond, ref startpos, left, right, TTimeFormat.tfSecond, ref endpos, 100, 100);
		}

		private void Button14_Click(object sender, System.EventArgs e)
		{
			int left = 0;
			int right = 0;
			TStreamTime startpos = new TStreamTime();
			TStreamTime endpos = new TStreamTime();

			player.GetPlayerVolume(ref left, ref right);
			player.GetPosition(ref startpos);
			endpos.sec = System.Convert.ToUInt32(startpos.sec + 5);
			player.SlideVolume(TTimeFormat.tfSecond, ref startpos, left, right, TTimeFormat.tfSecond, ref endpos, 0, 0);

		}

		private void CheckBox1_CheckedChanged(object sender, System.EventArgs e)
		{
			player.EnableEqualizer(((CheckBox)sender).Checked);
		}

		private void VScrollBar1_ValueChanged(object sender, System.EventArgs e)
		{
			if (player != null)
			{
                player.SetEqualizerPreampGain(20000 - ((VScrollBar)sender).Value * 1000);
			}
		}

		private void VScrollBar2_ValueChanged(object sender, System.EventArgs e)
		{
			if (player != null)
			{
				player.SetEqualizerBandGain(0, 20000 - ((VScrollBar)sender).Value * 1000);
			}
		}

		private void VScrollBar3_ValueChanged(object sender, System.EventArgs e)
		{
			if (player != null)
			{
				player.SetEqualizerBandGain(1, 20000 - ((VScrollBar)sender).Value * 1000);
			}
		}

		private void VScrollBar4_ValueChanged(object sender, System.EventArgs e)
		{
			if (player != null)
			{
				player.SetEqualizerBandGain(2, 20000 - ((VScrollBar)sender).Value * 1000);
			}
		}

		private void VScrollBar5_ValueChanged(object sender, System.EventArgs e)
		{
			if (player != null)
			{
				player.SetEqualizerBandGain(3, 20000 - ((VScrollBar)sender).Value * 1000);
			}
		}

		private void VScrollBar6_ValueChanged(object sender, System.EventArgs e)
		{
			if (player != null)
			{
				player.SetEqualizerBandGain(4, 20000 - ((VScrollBar)sender).Value * 1000);
			}
		}

		private void VScrollBar7_ValueChanged(object sender, System.EventArgs e)
		{
			if (player != null)
			{
				player.SetEqualizerBandGain(5, 20000 - ((VScrollBar)sender).Value * 1000);
			}
		}

		private void VScrollBar8_ValueChanged(object sender, System.EventArgs e)
		{
			if (player != null)
			{
				player.SetEqualizerBandGain(6, 20000 - ((VScrollBar)sender).Value * 1000);
			}
		}

		private void VScrollBar9_ValueChanged(object sender, System.EventArgs e)
		{
			if (player != null)
			{
				player.SetEqualizerBandGain(7, 20000 - ((VScrollBar)sender).Value * 1000);
			}


		}

		private void VScrollBar10_ValueChanged(object sender, System.EventArgs e)
		{
			if (player != null)
			{
				player.SetEqualizerBandGain(8, 20000 - ((VScrollBar)sender).Value * 1000);
			}
		}

		private void VScrollBar11_ValueChanged(object sender, System.EventArgs e)
		{
			if (player != null)
			{
				player.SetEqualizerBandGain(9, 20000 - ((VScrollBar)sender).Value * 1000);
			}
		}

		private void Button15_Click(object sender, System.EventArgs e)
		{
			Echo = ! Echo;
			player.EnableEcho(Echo);
		}

	

		private void VScrollBar12_ValueChanged(object sender, System.EventArgs e)
		{
			if (player != null)
			{
				player.SetPitch(200 - ((VScrollBar)sender).Value);
			}
		}

		private void VScrollBar13_ValueChanged(object sender, System.EventArgs e)
		{
			if (player != null)
			{
				player.SetTempo(200 - ((VScrollBar)sender).Value);
			}
		}

		private void VScrollBar14_ValueChanged(object sender, System.EventArgs e)
		{
			if (player != null)
			{
				player.SetRate(200 - ((VScrollBar)sender).Value);
			}
		}

		private void Button8_Click(object sender, System.EventArgs e)
		{
			SideCut = false;
			VocalCut = ! VocalCut;
            player.StereoCut(VocalCut, false, true);
		}

		private void Button16_Click(object sender, System.EventArgs e)
		{
			SideCut = ! SideCut;
			VocalCut = false;
            player.StereoCut(SideCut, true, false);

		}


		private void ComboBox1_SelectedIndexChanged(object sender, System.EventArgs e)
		{
			if (player != null)
			{
                player.SetFFTGraphParam(TFFTGraphParamID.gpGraphType, ((ComboBox)sender).SelectedIndex);
	
			}
		}

		private void FFTLinear_CheckedChanged(object sender, System.EventArgs e)
		{
			if (player != null)
			{
				if (((CheckBox)sender).Checked)
				{
                    player.SetFFTGraphParam(TFFTGraphParamID.gpHorizontalScale, (int) TFFTGraphHorizontalScale.gsLinear);
				}
				else
				{
                    player.SetFFTGraphParam(TFFTGraphParamID.gpHorizontalScale, (int) TFFTGraphHorizontalScale.gsLogarithmic);
				}
			}

		}

		private void ComboBox2_SelectedIndexChanged(object sender, System.EventArgs e)
		{
			int points = 0;
			points = System.Convert.ToInt32(Math.Pow(2, ((ComboBox)sender).SelectedIndex + 2));
			if (player != null)
			{
                player.SetFFTGraphParam(TFFTGraphParamID.gpFFTPoints, points);
			}
		}

		private void ComboBox3_SelectedIndexChanged(object sender, System.EventArgs e)
		{
			if (player != null)
			{
                player.SetFFTGraphParam(TFFTGraphParamID.gpWindow, (int)(((ComboBox)sender).SelectedIndex + 1));
			}
		}

		private void CheckBox2_CheckedChanged(object sender, System.EventArgs e)
		{
			if (player != null)
			{
				if (((CheckBox)sender).Checked)
				{
                    player.SetFFTGraphParam(TFFTGraphParamID.gpFrequencyGridVisible, 1);
                    player.SetFFTGraphParam(TFFTGraphParamID.gpDecibelGridVisible, 1);
				}
				else
				{
                    player.SetFFTGraphParam(TFFTGraphParamID.gpFrequencyGridVisible, 0);
                    player.SetFFTGraphParam(TFFTGraphParamID.gpDecibelGridVisible, 0);
				}
			}
		}

		private void Button17_Click(object sender, System.EventArgs e)
		{
			if (MessageBox.Show("This can take some time! Continue ?", "Detecting BPM", MessageBoxButtons.YesNoCancel) == System.Windows.Forms.DialogResult.Yes)
			{
				int BPM = 0;
				BPM = player.DetectBPM(TBPMDetectionMethod.dmPeaks);
				MessageBox.Show("BPM: " + System.Convert.ToString(BPM), "Detected BPM", MessageBoxButtons.OK);
			}
		}

		private void PictureBox1_Paint(object sender, System.Windows.Forms.PaintEventArgs e)
		{
			IntPtr MyDeviceContext = default(IntPtr);
			MyDeviceContext = e.Graphics.GetHdc();
			player.DrawFFTGraphOnHDC(MyDeviceContext, 0, 0, PictureBox1.Width, PictureBox1.Height);
			e.Graphics.ReleaseHdc(MyDeviceContext);
		}

		private void leftplayervolume_Scroll(object sender, ScrollEventArgs e)
		{

		}

        private void button18_Click(object sender, EventArgs e)
        {
            LoadMode = 3;
            OpenFileDialog1.ShowDialog();
        }

        private void checkBox3_CheckedChanged(object sender, EventArgs e)
        {
            if (player != null)
            {
                if (((CheckBox)sender).Checked)
                {
                    player.SetFFTGraphParam(TFFTGraphParamID.gpFrequencyScaleVisible, 1);
                    player.SetFFTGraphParam(TFFTGraphParamID.gpDecibelScaleVisible, 1);
                }
                else
                {
                    player.SetFFTGraphParam(TFFTGraphParamID.gpFrequencyScaleVisible, 0);
                    player.SetFFTGraphParam(TFFTGraphParamID.gpDecibelScaleVisible, 0);
                }
            }
        }

        private void button19_Click(object sender, EventArgs e)
        {
           
                player.Close();
                if (!(player.OpenFile("wavein://src=line;volume=50", TStreamFormat.sfWaveIn)))
                {
                    MessageBox.Show(player.GetError(), string.Empty, MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                }


                showinfo();
                player.StartPlayback();
            }

        private void button20_Click(object sender, EventArgs e)
        {
            player.Close();
            if (!(player.OpenFile("wavein://src=microphone;volume=50", TStreamFormat.sfWaveIn)))
            {
                MessageBox.Show(player.GetError(), string.Empty, MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }


            showinfo();
            player.StartPlayback();
        }

        private void button21_Click(object sender, EventArgs e)
        {
            LoadMode = 0;
            saveFileDialog1.ShowDialog();
        }

        private void button22_Click(object sender, EventArgs e)
        {
            LoadMode = 1;
            saveFileDialog1.ShowDialog();
        }

        private void saveFileDialog1_FileOk(object sender, System.ComponentModel.CancelEventArgs e)
        {
            switch (ComboBox5.SelectedIndex)
            {
                case 1:
                    player.SetWaveOutFile(((SaveFileDialog)sender).FileName, TStreamFormat.sfMp3, CheckBox4.Checked);
                    break;
                case 2:
                    player.SetWaveOutFile(((SaveFileDialog)sender).FileName, TStreamFormat.sfOgg, CheckBox4.Checked);
                    break;
                case 3:
                    player.SetWaveOutFile(((SaveFileDialog)sender).FileName, TStreamFormat.sfFLAC, CheckBox4.Checked);
                    break;
                case 4:
                    player.SetWaveOutFile(((SaveFileDialog)sender).FileName, TStreamFormat.sfFLACOgg, CheckBox4.Checked);
                    break;
                case 5:
                    player.SetWaveOutFile(((SaveFileDialog)sender).FileName, TStreamFormat.sfAacADTS, CheckBox4.Checked);
                    break;
                case 6:
                    player.SetWaveOutFile(((SaveFileDialog)sender).FileName, TStreamFormat.sfWav, CheckBox4.Checked);
                    break;
                case 7:
                    player.SetWaveOutFile(((SaveFileDialog)sender).FileName, TStreamFormat.sfPCM, CheckBox4.Checked);
                    break;
            }


            showinfo();
            player.StartPlayback();

           

        }

        private void Button20_Click_1(object sender, EventArgs e)
        {
            var file = "wavein://";

            switch (ComboBox4.SelectedIndex)
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
            player.Close();
            if (!(player.OpenFile(file, TStreamFormat.sfAutodetect)))
            {
                MessageBox.Show(player.GetError(), string.Empty, MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            if (ComboBox5.SelectedIndex > 0)
            {


                switch (ComboBox5.SelectedIndex)
                {
                    case 1:
                        saveFileDialog1.Filter = "Mp3 File|*.mp3";
                        saveFileDialog1.Title = "Save to mp3 file";
                        break;
                    case 2:
                        saveFileDialog1.Filter = "Ogg File|*.ogg";
                        saveFileDialog1.Title = "Save to ogg file";
                        break;
                    case 3:
                        saveFileDialog1.Filter = "FLAC File|*.flac";
                        saveFileDialog1.Title = "Save to FLAC file";
                        break;
                    case 4:
                        saveFileDialog1.Filter = "FLAC Ogg File|*.oga";
                        saveFileDialog1.Title = "Save to FLAC Ogg file";
                        break;
                    case 5:
                        saveFileDialog1.Filter = "AAC File|*.aac";
                        saveFileDialog1.Title = "Save to AAC file";
                        break;
                    case 6:
                        saveFileDialog1.Filter = "Wav File|*.wav";
                        saveFileDialog1.Title = "Save to Wave file";
                        break;
                    case 7:
                        saveFileDialog1.Filter = "RAW PCM File|*.pcm";
                        saveFileDialog1.Title = "Save to pcm file";
                        break;
                }

                saveFileDialog1.ShowDialog();
            }
            else
            {
                showinfo();
                player.StartPlayback();

            }
        }
       
	}

} //end of root namespace