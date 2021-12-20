import 'package:DartProject/base/config/YLZMacros.dart';
import 'package:DartProject/base/config/YLZStyle.dart';
import 'package:flutter/material.dart';

class MGPrivacyPolicyDetailViewPage extends StatelessWidget {
  const MGPrivacyPolicyDetailViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("AAAAAAAA");
    return Material(
        type: MaterialType.transparency,
        child: Container(
            child: Column(
          children: [
            Container(
              width: ScreenW(context),
              height: StatusH(context) + kToolbarHeight,
              color: Colors.white,
              child: Column(
                children: [
                  Container(width: ScreenW(context), height: StatusH(context)),
                  Stack(children: [
                    Container(
                      width: ScreenW(context),
                      height: kToolbarHeight,
                      alignment: Alignment.center,
                      child: Text(
                        "隐私政策",
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Color(YLZColorTitleOne),
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                        child: InkWell(
                          child: Container(
                            child: Image.asset("assets/images/topic_back.png"),
                            padding: EdgeInsets.fromLTRB(16, 20, 36, 20),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        left: 0,
                        top: 0)
                  ])
                ],
              ),
            ),
            Expanded(
                child: Container(
              width: ScreenW(context),
              height: ScreenH(context) - (kToolbarHeight + StatusH(context)),
              color: Colors.white,
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                child: Text(
                  "法律声明\n提示条款:\n提醒您：在使用萌果视频各项服务前，请您务必仔细阅读并透彻理解本声明。如对本声明内容有任何疑问，您可向平台客服咨询。阅读本声明的过程中，如果不同意本声明或其中任何内容，您应立即停止使用平台服务。如果您使用平台服务的，即意味着您认可本声明全部内容。\n定义:\n平台：指包括但不限于客户端。\n萌果视频：平台经营者的单称或合称，包括但不限于集团旗下子公司、分公司及关联公司等。\n权利声明:\n一、权利归属\n除非另有声明，平台内的所有产品、软件、程序、技术、数据及其他信息（包括但不限于文字、图像、照片、图片、视频、音频、图表、版面设计、电子文档）的所有权利（包括但不限于版权、商标权、专利权、商业秘密等知识产权及其他所有相关权利）均归或其关联公司所有。未经书面许可，任何人不得擅自使用（包括但不限于通过任何机器人、爬虫等程序或设备复制、传播、展示、监视、镜像、上载、下载平台内的任何内容）。\n平台的Logo、品牌等文字、图形及其组合，以及平台的其他标识、产品和服务名称均为及其关联公司在中国和其它国家的商标，未经书面授权，任何人不得以任何方式展示、使用或作其他处理，也不得向他人表明您有权展示、使用或作其他处理。\n二、知识产权保护，尊重知识产权，反对侵权盗版行为。知识产权权利人认为平台内容（包括但不限于平台会员发布的商品信息）可能涉嫌侵犯其合法权益，可以通过客服提出书面通知，收到后将及时处理。\n三、责任限制\n平台对其自行上传的内容在法律框架内承担责任；平台对用户自行发表的言论、商品信息等，不承担任何责任。\n平台对部分服务属于电子公告牌（BBS）性质，其中信息（包括但不限于公司名称、\n联系人及联络信息、产品的描述和说明、相关图片、视频等）均由会员自行提供并上传，由会员对其提供并上传的所有信息承担相应法律责任。\n用户平台转载作品（包括论坛内容）出于传递更多信息之目的，并不意味赞同其观点或已经证实其内容的真实性。\n隐私权政策: （下称“我们”）非常尊重用户个人信息的保护，在您使用平台提供的服务时，我们将按照本隐私权政策收集、使用及共享您的个人信息。本隐私权政策包含了我们收集、存储、使用、共享和保护您的个人信息的条款，建议您完整地阅读本隐私权政策，以帮助您了解维护自己隐私权的方式。如您对本隐私权政策有任何疑问，您可以通过平台公布的联系方式与我们联系。如果您不同意本隐私权政策任何内容，您应立即停止使用平台服务。如您继续使用平台的任一服务，即意味着您已同意我们按照本隐私权政策来合法收集、使用、储存和分享您的相关信息。\n一、适用范围\n本隐私权政策适用于平台提供的所有服务，您访问平台网站及/或登陆相关客户端使用平台提供的服务，均适用本隐私权政策。\n需要特别说明的是，本隐私权政策不适用于其他第三方向您提供的服务，例如上的卖家依托平台向您提供服务时，您向卖家提供的个人信息不适用于本隐私权政策。\n二、我们如何收集信息\n我们收集信息是为了向您提供优质、个性化的服务，我们收集信息的方式如下：\n1.您向我们提供的信息。\n当您注册账户及您在使用平台时提供的相关服务时填写及或提交的信息，包括您的姓名、性别、出生年月日、身份证号码、护照姓名、护照号码、电话号码、电子邮箱、地址、邮编、银行账号及相关附加信息。\n2.在您使用服务过程中收集的信息。\n为了提供并优化您需要的服务，我们会收集您使用服务的相关信息，这类信息包括：\n在您使用平台服务，或访问平台网页时，系统自动接收并记录的您的浏览器和计算机上的信息，包括但不限于您的IP地址、浏览器信息、访问日期和时间、语言、软硬件特征信息及您浏览的网页记录等数据；如您访问移动网页使用平台服务，或下载或使用或其关联公司客户端软件，可能会读取与您位置和移动设备相关的信息，包括但不限于设备型号、操作系统、设备识别码、分辨率、电信运营商等。\n除上述信息外，我们还可能为了提供服务及改进服务质量、服务个性化等合理需要而收集您的其他信息，包括您与我们的客户服务团队联系时您提供的相关信息，您参与问卷调查活动时向我们提供的问卷答复信息，以及您与的关联方、合作伙伴之间互动时我们收集的相关信息。与此同时，为提高您使用平台服务时的安全性，预防钓鱼网站欺诈和木马病毒，我们可能会通过了解或记录一些您的网络使用习惯、您常用的软件信息等手段来判断您账户的风险，并可能会记录一些我们认为有风险的URL。\n3.来自第三方的信息\n为了给您提供更好、更优、更加个性化的服务，或共同为您提供服务，或为了预防互联网欺诈的目的，的关联方、合作伙伴会依据法律的规定或与您的约定或征得您同意的前提下，向分享您的个人信息。\n您了解并同意，以下信息不适用本隐私权政策：\na）您在平台进行交易的有关数据，包括但不限于出价、成交信息及评价等数据；\nb）您在使用平台提供的搜索服务时输入的关键字信息；\nc）信用评价、违反法律规定或违反规则行为及已对您采取的措施；\nd)应法律法规要求需公示的企业名称等相关工商注册信息以及自然人经营者的信息。\n三、我们如何使用信息\n收集您的信息是为了向您提供优质、个性化服务的目的，为了实现该目的，我们会把您的信息用于下列用途：\n1.向您提供您使用的各项服务，并维护、改进这些服务。\n2.向您推荐您可能感兴趣的内容，包括但不限于通过系统向您展示个性化的推广信息，向您发出产品和服务信息，或者在征得您同意的情况下与的合作伙伴共享信息以便他们向您发送有关其产品和服务的信息。如您不希望接收上述信息，可通过相应的退订功能进行退订。\n3.我们可能使用您的个人信息以预防、发现、调查欺诈、危害安全、非法或违反与我们或其关联方协议、政策或规则的行为，以保护您、其他我们用户，或我们或其关联方的合法权益。\n4.我们可能会将来自某项服务的个人信息与来自其他服务的信息结合起来，用于为了给您提供更加个性化的服务使用，例如让您拥有更广泛的社交圈的需要而使用、共享或披露。\n5.经您许可的其他用途。\n四、我们如何共享信息\n我们对您的信息承担保密义务，不会为满足第三方的营销目的而向其出售或出租您的任何信息，我们会在下列情况下才将您的信息与第三方共享：\n1.事先获得您的同意或授权。\n2.根据法律法规的规定或行政或司法机构的要求。\n3.向关联方分享您的个人信息。\n4.向可信赖的合作伙伴提供您的个人信息，让他们根据我们的指示并遵循我们的隐私权政策以及其他任何相应的保密和安全措施来为我们处理这些信息。\n5.如您出现违反中国有关法律、法规或者相关协议或相关规则的情况，需要向第三方披露。\n6.为维护及其关联方或用户的合法权益。\n五、Cookie 和网络 Beacon 的使用\n为使您获得更轻松的访问体验，您访问平台相关网站或使用平台提供的服务时，我们可能会通过Cookie，Flash Cookie，或您的浏览器或关联应用程序提供的其他本地存储（统称“Cookie”），以向您提供个性化的用户体验和服务。 请您理解，我们的某些服务只能通过使用“Cookie”才可得到实现。如果您的浏览器或浏览器附加服务允许，您可以修改对Cookie的接受程度或者拒绝的Cookie，但这一举动可能会影响您安全访问平台相关网站和使用平台提供的服务。网页上常会包含一些电子图象（称为\"单像素\" GIF 文件或 \"网络 beacon\"），使用网络beacon可以帮助网站计算浏览网页的用户或访问某些cookie，我们会通过网络beacon收集您浏览网页活动的信息，例如您访问的页面地址、您先前访问的援引页面的位址、您停留在页面的时间、您的浏览环境以及显示设定等。\n六、信息存储\n收集的有关您的信息和资料将保存在及（或）其关联公司的服务器上，这些信息和资料可能传送至您所在国家、地区或收集信息和资料所在地并在该地被访问、存储和展示。\n七、您的个人信息保护\n为保障您的信息安全，我们努力采取各种合理的安全措施来保护您的信息，以防信息的泄漏、毁损或者丢失，包括但不限于SSL、信息加密存储、数据中心的访问控制。我们对可能接触到您的信息的员工或外包人员也采取了严格管理，包括但不限于与他们签署保密协议，根据岗位的不同采取不同的权限控制，监控他们的操作情况等措施。您的账户均有安全保护功能，请妥善保管您的账户及密码信息。将通过向其它服务器备份、对用户密码进行加密等安全措施确保您的信息不丢失，不被滥用和变造。尽管有前述安全措施，但也请您理解，由于技术的限制以及可能存在的各种恶意行为，在互联网上不能保证百分之百的安全。\n请您妥善保护自己的个人信息，仅在必要的情形下向他人提供，并且对此行为产生的后果承担责任。在您使用我们的服务时所提供、上传、或发布的内容和信息（比如照片），可能会泄露您的敏感个人信息，请您慎重考虑是否在使用使披露。如您发现自己的个人信息泄密，尤其是你的账户及密码发生泄露，请您立即联络客服，以便采取相应措施。\n八、未成年人保护\n我们重视未成年人的个人信息保护，如您为未成年人，建议您请您的监护人仔细阅读本隐私权政策，并在征得您的监护人同意的前提下使用我们的服务或向我们提供信息。",
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Color(YLZColorTitleOne),
                      fontSize: 16),
                ),
              ),
            ))
          ],
        )));
  }
}
