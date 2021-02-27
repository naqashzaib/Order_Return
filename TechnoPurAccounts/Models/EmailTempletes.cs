﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TechnoPurAccounts.Models
{
    public class EmailTempletes
    {

        public static string FunEmailTemplete(string handingtext, string user_email, string buttontext, string VerifyCode,string url)
        {
            return "<div style='margin: 0pt auto; padding: 0px; background:#F7F7F7;' class='emailsendbody'> <table id='main' width='100%' height='100%' cellpadding='0' cellspacing='0' border='0' bgcolor='#F4F7FA'> <tbody> <tr> <td valign='top'> <table class='innermain' cellpadding='0' width='580' cellspacing='0' border='0' bgcolor='#F4F7FA' align='center' style='margin:0 auto; table-layout: fixed;'> <tbody> <tr> <td colspan='4'> <table class='logo' width='100%' cellpadding='0' cellspacing='0' border='0'> <tbody> <tr> <td colspan='2' height='30'></td> </tr> <tr> <td valign='top' align='center'> <a href='https://www.genial365.com/' style='display:inline-block; cursor:pointer; text-align:center;'> <img src='http://www.accounts-demo.genial365.com/images/genial_logo_icon.png' height='auto' width='104' border='0' alt='Coinbase'> </a> </td> </tr> <tr> <td colspan='2' height='30'></td> </tr> </tbody> </table> <table width='100%' cellpadding='0' cellspacing='0' border='0' bgcolor='#ffffff' style='border-radius: 4px; box-shadow: 0 2px 8px rgba(0,0,0,0.05);'> <tbody> <tr> <td height='40'></td> </tr> <tr style='font-family: -apple-system,BlinkMacSystemFont,&#39;Segoe UI&#39;,&#39;Roboto&#39;,&#39;Oxygen&#39;,&#39;Ubuntu&#39;,&#39;Cantarell&#39;,&#39;Fira Sans&#39;,&#39;Droid Sans&#39;,&#39;Helvetica Neue&#39;,sans-serif; color:#4E5C6E; font-size:14px; line-height:20px; margin-top:20px;'> <td class='content' colspan='2' valign='top' align='center' style='padding-left:90px; padding-right:90px;'> <table width='100%' cellpadding='0' cellspacing='0' border='0' bgcolor='#ffffff'> <tbody> <tr> <td align='center' valign='bottom' colspan='2' cellpadding='3'> <img alt='Coinbase' width='80' src='https://i.ibb.co/VLr1VFK/succeed-b8b07e13b329343ae5d10a921613e8aa5d3ac2d3b1f0428db69b591108cc3d44.pnga' /> </td> </tr> <tr> <td height='30' &nbsp;='></td> </tr> <tr> <td align='center'> <span style='color:#48545d;font-size:22px;line-height: 24px;' id='handingtext'> " + handingtext + "</span> </td> </tr> <tr> <td height='1' &nbsp;='></td> </tr> <tr> <td height='1' bgcolor='#DAE1E9'></td> </tr> <tr> <td height='24' &nbsp;='></td> </tr> <tr> <td align='center'> <span style='color:#48545d;font-size:14px;line-height:24px;'> We received a request to register the <b id='useremail'>" + user_email + "</b> account at Genial365 Erp System To complete the process you must </span> </td> </tr> <tr> <td height='24' &nbsp;='></td> </tr> <tr> <td align='center'> <span style='color:#48545d;font-size:14px;line-height:24px;'>  Verify Code: <b id='VerifyCode'>" + VerifyCode + "</b> </span> </td> </tr> <tr> <td height='20' &nbsp;='></td> </tr> <tr> <td valign='top' width='48%' align='center'> <span> <a href='" + url + "' id='geturl' style='display:block; padding:15px 25px; background-color:#0087D1; color:#ffffff; border-radius:3px; text-decoration:none;'><span id='buttontext'>" + buttontext + "</span></a> </span> </td> </tr> <tr> <td height='20' &nbsp;='></td> </tr> <tr> <td align='center'> <img src='../img/hr.png' width='54' height='2' border='0'> </td> </tr> <tr> <td height='20' &nbsp;='></td> </tr> <tr> <td align='center'> <p style='color:#a2a2a2; font-size:12px; line-height:17px; font-style:italic;'>If you did not sign up for this account you can ignore this email and the account will be deleted.</p> </td> </tr> </tbody> </table> </td> </tr> <tr> <td height='60'></td> </tr> </tbody> </table> <!-- Main CONTENT end here --> <!-- PROMO column start here --> <!-- Show mobile promo 75% of the time --> <!-- PROMO column end here --> <!-- FOOTER start here --> <table width='100%' cellpadding='0' cellspacing='0' border='0'> <tbody> <tr> <td height='10'>&nbsp;</td> </tr> <tr> <td valign='top' align='center'> <span style='font-family: -apple-system,BlinkMacSystemFont,&#39;Segoe UI&#39;,&#39;Roboto&#39;,&#39;Oxygen&#39;,&#39;Ubuntu&#39;,&#39;Cantarell&#39;,&#39;Fira Sans&#39;,&#39;Droid Sans&#39;,&#39;Helvetica Neue&#39;,sans-serif; color:#9EB0C9; font-size:10px;'>&copy; <a href='https://www.genial365.com/' target='_blank' style='color: #9EB0C9 !important; font-weight: 700; text-decoration: none; font-size: 11px;'>TechnuPur</a> 2020 </span> </td> </tr> <tr> <td height='50'>&nbsp;</td> </tr> </tbody> </table> <!-- FOOTER end here --> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> </div>";
        }

    }
}