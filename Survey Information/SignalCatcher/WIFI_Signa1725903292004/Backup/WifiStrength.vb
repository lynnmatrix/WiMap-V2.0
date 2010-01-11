Imports System.Management
Imports System.Math

Public Class WifiStrength

    Public Function GetFakedSignalStrengthImage() As Bitmap

        ' this function is used as a test - as I dont have wifi to test the true function
        ' this function is based off a rand numb

        Dim g As Graphics
        Dim bmp As New Bitmap(52, 16)
        Dim f As New Font("Verdana", 6, FontStyle.Bold)
        Dim brush As New SolidBrush(Color.Black)
        Dim dbl_Strength As Double
        Dim dbl_Strength_Lower As Double
        Dim intLoop As Integer

        g = Graphics.FromImage(bmp)

        dbl_Strength = CInt(Rnd(1) * 10)

        g.FillRectangle(brush, 0, 0, 52, 16) ' draw the outer frame

        brush.Color = Color.White

        g.FillRectangle(brush, 1, 1, 50, 14) ' draw the inner frame

        If dbl_Strength = -1 Then

            ' Signal strength of - 1 mean sthat the signal cant be located (i.e. not support etc)

            brush.Color = Color.Black

            g.DrawString("No Signal", f, brush, 2, 3)

        Else

            ' covert siginal strength from a presumed 0 - 100 range into a 0 - 10 range

            'dbl_Strength_Lower = Ceiling(dbl_Strength / 10)

            For intLoop = 0 To CInt(dbl_Strength) - 1

                ' draw a signal bar per dbl_Strength_Lower

                brush.Color = Color.Red

                g.FillRectangle(brush, (intLoop * 5) + 1, 1, 4, 14)

                brush.Color = Color.DarkGray

                g.FillRectangle(brush, (intLoop * 5) + 5, 1, 1, 14)

            Next

        End If

        GetFakedSignalStrengthImage = bmp ' return new image

    End Function

    Public Function GetSignalStrengthImage() As Bitmap

        Dim g As Graphics
        Dim bmp As New Bitmap(52, 16)
        Dim f As New Font("Verdana", 6, FontStyle.Bold)
        Dim brush As New SolidBrush(Color.Black)
        Dim dbl_Strength As Double
        Dim dbl_Strength_Lower As Double
        Dim intLoop As Integer

        g = Graphics.FromImage(bmp)

        dbl_Strength = GetSignalStrength()

        g.FillRectangle(brush, 0, 0, 52, 16) ' draw the outer frame

        brush.Color = Color.White

        g.FillRectangle(brush, 1, 1, 50, 14) ' draw the inner frame

        If dbl_Strength = -1 Then

            ' Signal strength of - 1 mean sthat the signal cant be located (i.e. not support etc)

            brush.Color = Color.Black

            g.DrawString("No Signal", f, brush, 2, 3)

        Else

            ' covert siginal strength from a presumed 0 - 100 range into a 0 - 10 range

            dbl_Strength_Lower = Ceiling(dbl_Strength / 10)

            For intLoop = 0 To CInt(dbl_Strength_Lower) - 1

                ' draw a signal bar per dbl_Strength_Lower

                brush.Color = Color.Red

                g.FillRectangle(brush, (intLoop * 5) + 1, 1, 4, 14)

                brush.Color = Color.DarkGray

                g.FillRectangle(brush, (intLoop * 5) + 5, 1, 1, 14)

            Next

        End If

        GetSignalStrengthImage = bmp ' return new image

    End Function

    Public Function GetSignalStrength() As Double

        ' This code was located on the internet (original sourtce unkown) and changed slightly by me
        ' Based on the presumption that the siginal strength is return as a 0 - 100 value, I have a feeling that its not, but cant find any docs on it
        ' if someone could test this function 

        Dim query As ManagementObjectSearcher
        Dim Qc As ManagementObjectCollection
        Dim Oq As ObjectQuery
        Dim Ms As ManagementScope
        Dim Co As ConnectionOptions
        Dim Mo As ManagementObject
        Dim dbl_strength As Double

        Try

            Co = New ConnectionOptions
            Ms = New ManagementScope("root\wmi")
            Oq = New ObjectQuery("SELECT * FROM MSNdis_80211_ReceivedSignalStrength Where active=true")
            query = New ManagementObjectSearcher(Ms, Oq)
            Qc = query.Get
            dbl_strength = 0

            For Each Mo In query.Get
                dbl_strength = dbl_strength + Convert.ToDouble(Mo("Ndis80211ReceivedSignalStrength")) ' Not sure if this line works , due to an unkown return from Ndis80211ReceivedSignalStrength
            Next


            ' THIS IS THE ORIGINAL CODE WHICH SEEMS TO RETURN A STRING - THEREFORE MAKING MY CODE INVALID
            ' BUT AS I CANT TEST IT I DONT KNOW WHAT THE OUTPUT IS

            'For Each Mo In query.Get
            'outp = outp & Mo("Ndis80211ReceivedSignalStrength") & " "
            'ISIPActive = Mo("Active")
            'Next

        Catch exp As Exception

            ' Return zero as no signal
            dbl_strength = -1

        End Try

        Return Convert.ToDouble(dbl_strength)

    End Function

End Class
