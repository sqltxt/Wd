;ʱ���
;����
;1:	[08:41:00]		TB����
;2:	[08:42:00]		TB��¼
;3:	[08:53:00]		��������
;4:	[08:54:00]		�������
;5:	[15:35:00]		�������й�����
;6:	[15:36:00]		�رռ��
;7:	[15:37:00]		ֹͣ�����Զ�����
;8:	[15:58:00]		�ر�TB
;ҹ��
;1:	[20:41:00]		TB����
;2:	[20:42:00]		TB��¼
;3:	[20:53:00]		��������
;4:	[20:54:00]		�������
;5:	[02:35:00]		�������й�����
;6:	[02:36:00]		�رռ��
;7:	[02:37:00]		ֹͣ�����Զ�����
;8:	[02:58:00]		�ر�TB
;���������
;0:	[08:40:00]		������ɱ
;9:	[08:49:00]		�������
;10:[08:50:00]		�˻���¼
;11:[08:51:00]		��¼ʧ��

;��־�ļ�����һ�����£�
;�������		1��2��3��4��5��6��7��8
;�ǽ�����		1��2��10��11��8
;�������		1��2��9��8
;�ֶ���¼		1��2��10��3��4��5��6��7��8
;��ĩ����		20

#include <Date.au3>
#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <Constants.au3>
Global $TBloginName		=	"sqltxt"
Global $TBloginPassword	=	"iamanothwolf"
Global $TBInstallPath	=	"C:\Users\Administrator\Documents\tbv5416_x64_portable"
Global $ExpirationDate  =	"2099/01/01";ע���ʽΪ��YYYY/MM/DD��
Global $ExpirationDate  =	"2099/01/01";ע���ʽΪ��YYYY/MM/DD��
Global $LogName
Global $LogTime
Global $Week[7] = ['����', '��һ', '�ܶ�', '����', '����', '����', '����']
Global $s = 0
Global $f = 0
Global $t = 0
Global $o = 0

If ($TBloginName == "sqltxt" Or $TBloginName == "gentle" Or $TBloginName == "wkjy81103027") Then $f =1
If $f == 1 Then Filewriteline($TBInstallPath  & "\log\LOG_" & @YEAR & @MON & @MDAY & "_"& $Week[@WDAY - 1]&".txt", "  " & @TAB & "[" & @HOUR & ":" & @MIN & ":" & @SEC & "]" & @TAB & @TAB & "AutoRunTB����")
If $f == 1 Then Filewriteline($TBInstallPath  & "\log\LOG_" & @YEAR & @MON & @MDAY & "_"& $Week[@WDAY - 1]&".txt", "");����һ��



;������������ʱ������һ��ҹ��ʱ������һ��
While 1
        $LogName			=	$TBInstallPath  & "\log\LOG_" & @YEAR & @MON & @MDAY & "_"& $Week[@WDAY - 1]&".txt"
        $LogTime			=	"[" & @HOUR & ":" & @MIN & ":" & @SEC & "]" & @TAB & @TAB

        ;��һ������
        If @WDAY > 1 And @WDAY <= 7 Then	;@WDAYָʾ���������ܵĵڼ���,ֵ�ķ�Χ�� 1 �� 7,���α�ʾ�����쵽������.
                ;��ǰ����
                If (@MIN > 39 And @MIN <=59 And @SEC <= 59 And (@HOUR = 8 Or @HOUR = 20) And $t <3 And $o ==0) Then;ɱ����
                        Kill()
						Sleep(1000)
                ;����TB
                        TBStar()
						Sleep(60000)
                ;��¼TB
                        TBlogin()
						Sleep(1000)
                ;���ڼ��
                        Expired()
						Sleep(1000)
                ;��¼�˻�
                        AccountLogin()
						Sleep(1000)
                ;��¼ʧ��
                        LoginFail()
						Sleep(1000)
                ;��������
                        TradeStar()
						Sleep(1000)
                ;�������
                        MonitorStar()
						$t = $t+1
			    EndIf
			    ;���м��
					 ;TradeLog()
                ;�̺���
                If (@MIN = 35 And @SEC = 0 And (@HOUR = 2 Or @HOUR = 15)) Then;���湤����
                        SaveWorkSpace()
						Sleep(1000)
                ;�رռ��
                        MonitorClose()
						Sleep(1000)
                ;ֹͣ����
                        TradeStop()
						Sleep(1000)
                ;�ر�TB
                        TBClose()
						Sleep(1000)
                ;��ɨ
                        rubber()
						$t = 0
                EndIf
                ;ÿ������
        ElseIf (@WDAY = 1 And @HOUR = 12 And @MIN = 0 And @sec = 0) Then;��������
                ShutdownR()
        EndIf
        Sleep(1000)
	 WEnd

;�������0����ս���
Func Kill()
	     If $f == 1 Then Filewriteline($LogName, "#:" & @TAB & $LogTime & "��" & $t+1 &"�ε�¼")
        If ProcessExists("TradeBlazer.exe")  Then	;����ǰ������
                ProcessClose("TradeBlazer.exe")		;�ر�TB
                ProcessClose("TBDataCenter.exe")	;�ر�������
                If $f == 1 Then Filewriteline($LogName, "0:" & @TAB & $LogTime & "��������")
        EndIf
EndFunc
;�������1��TB����
Func TBStar()
        If Not WinExists ("���׿�����ƽ̨(�콢��)") Then	;����ǰ������
                Run($TBInstallPath & "\TradeBlazer.exe", $TBInstallPath)
				Sleep(10000);
                If $f == 1 Then Filewriteline($LogName, "1:" & @TAB & $LogTime & "����������")
        EndIf
EndFunc
;�������2��TB��¼
Func TBLogin()
        If WinExists("��ͣ�Զ���¼�����ʻ�") = 0 Then 	;����ǰ������
                WinActivate("","��ͣ�Զ���¼�����ʻ�")
                ControlFocus("","��ͣ�Զ���¼�����ʻ�","ComboBox1")
                ControlSetText("","��ͣ�Զ���¼�����ʻ�","ComboBox1", $TBloginName)
                ControlFocus("","��ͣ�Զ���¼�����ʻ�","Edit2")
                ControlSetText("","��ͣ�Զ���¼�����ʻ�","Edit2", $TBloginPassword)
                ControlClick("","��ͣ�Զ���¼�����ʻ�", 1000)
                If $f == 1 Then Filewriteline($LogName, "2:" & @TAB & $LogTime & "��¼������")
                Sleep(90000);��¼��ϵȴ�90�룬ģ���̨��¼����Ҫ70��
        EndIf
        If WinExists("ȷ��") = 0 Then
                WinActivate("","ȷ��")
                ControlFocus("","ȷ��","Button")
                ControlClick("","ȷ��", 1000)
                Sleep(9000)
        EndIf
        if WinExists("ȷ��", "�������ӵ��ڻ����������") Then
                WinClose("ȷ��", "�������ӵ��ڻ����������")
        EndIf
        Sleep(10000);��ͣ10��
EndFunc
;�������3����������
Func TradeStar()
		 WinSetOnTop("���׿�����ƽ̨(�콢��) 64λ -","", 1)
	  ;WinWaitActive("���׿�����ƽ̨(�콢��) 64λ -","")
		 WinActivate("���׿�����ƽ̨(�콢��) 64λ -")
        If ControlListView ( "���׿�����ƽ̨(�콢��)", "", "SysListView321", "GetItemCount") >= 1	Then
                WinMenuSelectItem("���׿�����ƽ̨(�콢��)", "","�ļ�(&F)", "���������Զ�����")
                If $f == 1 Then Filewriteline($LogName, "3:" & @TAB & $LogTime & "��������")
			 EndIf
			 Sleep(3000)
EndFunc
;�������4���������
Func MonitorStar()
		 WinSetOnTop("���׿�����ƽ̨(�콢��) 64λ -","", 1)
		 ;WinWaitActive("���׿�����ƽ̨(�콢��) 64λ -","")
		 WinActivate("���׿�����ƽ̨(�콢��) 64λ -","")
        If ControlListView ( "���׿�����ƽ̨(�콢��)" ,"", "SysListView321", "GetItemCount") >= 1	Then
                WinMenuSelectItem("���׿�����ƽ̨(�콢��)","","����(&T)", "�����")
			    Sleep(100)
				;WinWaitActive("�Զ�����ͷ������","", 5);��ͣ�ű���ִ�У�5�룩��ֱ�����ڱ�����
                WinActivate("���׿�����ƽ̨(�콢��) 64λ -")
				;ControlClick("�Զ�����ͷ������","",2316)
			    ;Sleep(500)
				ControlClick("�Զ�����ͷ������","",2316)
			    Sleep(500)
                If $f == 1 Then Filewriteline($LogName, "4:" & @TAB & $LogTime & "�������")
			    $o = 1
			 EndIf
		 WinSetState("�Զ�����ͷ������", "", @SW_SHOW)
		 ;WinSetOnTop ( "�Զ�����ͷ������", "�����ı�", 1 )
		 WinSetOnTop("�Զ�����ͷ������", "", 1)

EndFunc
;�������5�����湤����
Func SaveWorkSpace()
        if WinExists("���׿�����ƽ̨(�콢��) 64λ -") Then
                WinMenuSelectItem("���׿�����ƽ̨(�콢��)", "","�ļ�(&F)", "�������й�����");
                If $f == 1 Then Filewriteline($LogName, "5:" & @TAB & $LogTime & "���湤����")
        EndIf
EndFunc
;�������6���رռ��
Func MonitorClose()
        if WinExists("�Զ�����ͷ������", "") Then
                ControlFocus("�Զ�����ͷ������", "","Button25")
                ControlClick("�Զ�����ͷ������", "","Button25")
                Sleep(3000)
                If WinExists("ȷ��") Then
                        ControlFocus("ȷ��", "��(&Y)", "Button1")
                        ControlClick("ȷ��", "��(&Y)", "Button1")
                        If $f == 1 Then Filewriteline($LogName, "6:" & @TAB & $LogTime & "�رռ��")
                        Sleep(3000)
                EndIf
        EndIf
EndFunc
;�������7��ֹͣ�����Զ�����
Func TradeStop()
        if WinExists("���׿�����ƽ̨(�콢��) 64λ -") Then
                WinMenuSelectItem("���׿�����ƽ̨(�콢��)","","�ļ�(&F)","ֹͣ�����Զ�����");
                If $f == 1 Then Filewriteline($LogName, "7:" & @TAB & $LogTime & "ֹͣ����")
                Sleep(3000)
        EndIf
EndFunc
;�������8���ر�TB
Func TBClose()
		 if WinExists("���׿�����ƽ̨(�콢��) 64λ -") Then
                WinClose("���׿�����ƽ̨(�콢��) 64λ -")
                Sleep(3000)
                If WinExists("ȷ��", "") Then
                        ControlClick("ȷ��", "","Button1")
                        If $f == 1 Then Filewriteline($LogName, "8:" & @TAB & $LogTime & "�رտ�����")
                        If $f == 1 Then Filewriteline($LogName, "");����һ��
                        Sleep(3000)
						$o = 0
                EndIf
        EndIf
EndFunc
;�������9���������
Func Expired()
        If (_NowCalcDate() >= $ExpirationDate  ) Then					;����ǰ������
                If $f == 1 Then Filewriteline($LogName, "9:" & @TAB & $LogTime & "��������գ�" & $ExpirationDate )
                MsgBox(4096, "�����ѹ���", "��ϵ�绰��13299962008ţ")
                TBClose()
                Sleep(600000);����10����
	    ElseIf(_NowCalcDate()<$ExpirationDate And _NowCalcDate()>_DateAdd( 'w',-12, $ExpirationDate)) Then
			    MsgBox( 0, "��ʾ", "�������򼴽����ڣ�������: " & $ExpirationDate,50 );2460���9��룩���Զ��ر�
				WinActivate("���׿�����ƽ̨(�콢��)","")
			 EndIf
EndFunc
;�������10���˻���¼
Func AccountLogin()
        if ControlListView ( "���׿�����ƽ̨(�콢��)", "", "SysListView321", "GetItemCount") < 1 Then
                WinMenuSelectItem("���׿�����ƽ̨(�콢��) 64λ - ","","����(&T)","�����ʻ���¼")
                WinWaitActive("�ʻ���¼", "", 20)
                WinActivate("�ʻ���¼")
                ControlFocus("�ʻ���¼", "","Button1")
                Sleep(1000)
                ControlClick("�ʻ���¼", "","Button1")
                If $f == 1 Then Filewriteline($LogName, "10:" & @TAB & $LogTime & "�ٴε�¼")
        EndIf
EndFunc
;�������11����¼ʧ��
Func LoginFail()
        If ControlListView ( "���׿�����ƽ̨(�콢��)", "", "SysListView321", "GetItemCount") < 1 Then
                If $f == 1 Then Filewriteline($LogName, "11:" & @TAB & $LogTime & "��̨�ر�")
                TBClose()
        EndIf
EndFunc
;�������20������ϵͳ
Func ShutdownR()
	    If @OSVersion == "WIN_7" Then
			   If $f == 1 Then Filewriteline($LogName, "20:" & @TAB & $LogTime & "��ĩ����ϵͳ")
			   Run("shutdown -r")
			Else
			   If $f == 1 Then Filewriteline($LogName, "20:" & @TAB & $LogTime & "��WIN7ϵͳ��ĩ������")
		EndIf
EndFunc
;�������30����ȡ���׼�¼
Func TradeLog()
		 ;ƴ���ļ����ִ�
		 $TradeName			=	$TBInstallPath &"\AutoTrade\" & @YEAR & @MON & @MDAY & ".log"
		 ;���ļ�����
		 if FileExists ($TradeName) Then
			;���ļ����
			$TradeLog			=	FileOpen($TradeName)
			;�ļ���ʧ��
			If $TradeLog = -1 Then
			   ;д����־
			   If $f == 1 Then Filewriteline($LogName, "30:" & @TAB & $LogTime & "����,�޷����ļ�." & $TradeName)
			EndIf
			;������ļ���С
			$size=FileGetSize($TradeName)
			;�ļ���С�����仯
			If $size<>$s Then
			   ;�����ļ��α�
			   If FileSetPos($TradeLog, $s, $FILE_BEGIN) Then
				  ;��ȡ�α�����ļ�����
				  If $f == 1 Then Filewriteline($LogName, "30:" & @TAB & $LogTime & FileRead($TradeLog))
				  ;���þ��ļ���С(ȫ�ֱ���)
				  $s=$size
			   EndIf
			EndIf
			;�ر��ļ����
			FileClose($TradeLog)
		 EndIf
EndFunc
;�������40������ۼ�
Func rubber ()
   Global $TBInstallPath1	=	"C:\Users\Administrator\Documents\tbv5242_x64_portable"
   Global $TBInstallPath2	=	"C:\Users\Administrator\Documents\tbv5257_x64_portable"
   Global $TBInstallPath3	=	"C:\Users\Administrator\Documents\tbv5321_x64_portable"
   Global $TBInstallPath4	=	"C:\Users\Administrator\Documents\tbv5331_x64_portable"
   ;Global $TBInstallPath5	=	"C:\Users\Administrator\Documents\tbv5331_x64_portable"
   ;Global $TBInstallPath6	=	"C:\Users\Administrator\Documents\1\" & "???????????" & "_portable"

   FileDelete($TBInstallPath1  & "\LOG_" & "???????????" &".txt")
   FileDelete($TBInstallPath1  & "\LOG_" & "????????" &".txt")

   FileDelete($TBInstallPath2  & "\LOG_" & "???????????" &".txt")
   FileDelete($TBInstallPath2  & "\LOG_" & "????????" &".txt")

   FileDelete($TBInstallPath3  & "\LOG_" & "???????????" &".txt")
   FileDelete($TBInstallPath3  & "\LOG_" & "????????" &".txt")

   FileDelete($TBInstallPath4  & "\LOG_" & "???????????" &".txt")
   FileDelete($TBInstallPath4  & "\LOG_" & "????????" &".txt")

   ;FileDelete($TBInstallPath6  & "\LOG_" & "???????????" &".txt")
   ;FileDelete($TBInstallPath6  & "\LOG_" & "????????" &".txt")
EndFunc