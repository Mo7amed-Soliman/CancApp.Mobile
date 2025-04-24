class PostModel {
  final String userName;
  final String userImageUrl;
  final String postTime;
  final String contentPost;
  final String? imageUrl;
  final bool hasImage;
  final int likes;
  final int comments;
  final String userId;
  final String postId;

  PostModel({
    required this.userName,
    required this.userImageUrl,
    required this.hasImage,
    required this.likes,
    required this.comments,
    this.imageUrl,
    required this.userId,
    required this.postId,
    required this.contentPost,
    required this.postTime,
  });
}

List<PostModel> posts = [
  PostModel(
    userName: 'Dr.Mohamed Ahmed',
    userImageUrl: 'assets/images/dummy_image/img6.png',
    postTime: '3 h',
    contentPost:
        '''السرطان هو مرض خطير يحدث نتيجة نمو غير طبيعي وخارج عن السيطرة لخلايا الجسم. يمكن أن يصيب أي جزء من الجسم، ويُطلق عليه اسم الورم الخبيث عندما تنتشر الخلايا إلى أماكن أخرى. تختلف أنواع السرطان باختلاف العضو المصاب، مثل سرطان الثدي، الرئة، القولون، أو الدم. السبب الدقيق للإصابة بالسرطان غير معروف دائمًا، لكنه يرتبط بعوامل مثل التدخين، التعرض للإشعاعات، الوراثة، ونمط الحياة غير الصحي. تبدأ الأعراض بحسب نوع السرطان، وقد تشمل تعبًا غير مبرر، فقدان وزن، كتل أو أورام، أو نزيف غير طبيعي. يُشخص السرطان عبر الفحوصات والصور والتحاليل، وأحيانًا خزعة من النسيج. تختلف طرق العلاج وتشمل الجراحة، والعلاج الكيميائي، والإشعاعي، والمناعي. الكشف المبكر يزيد من فرص الشفاء ويقلل من المضاعفات. من المهم التوعية والفحص المنتظم، خاصة لمن لديهم عوامل خطورة.''',
    likes: 30,
    comments: 20,
    hasImage: false,
    imageUrl: null,
    userId: '1',
    postId: '1',
  ),
  PostModel(
    userName: 'Zahra Ahmed',
    userImageUrl: 'assets/images/dummy_image/img1.png',
    postTime: '4 h',
    contentPost:
        """I've been battling cancer for a while now, and I've learned a lot through this journey. I wanted to share some tips that helped me stay strong: stay positive, surround yourself with supportive people, and never hesitate to ask for help. We're all in this together.
I’ve learned that strength doesn’t mean never falling—it means getting back up every single time.
Each new day brings a fresh chance for hope, even when pain is present.
Patience isn’t about giving up; it’s about believing that healing can come tomorrow.
Smile, even in the tough moments—your smile might inspire someone else.
Write down your thoughts, no matter how small; expressing them can ease the heart.
Remember, your journey is unique, and every step forward is a victory.
And above all, life is worth holding onto, no matter how hard it gets.""",
    likes: 100,
    comments: 30,
    hasImage: false,
    imageUrl: null,
    userId: '2',
    postId: '2',
  ),
  PostModel(
    userName: 'Dr.Ahmed Ali',
    userImageUrl: 'assets/images/dummy_image/img3.png',
    postTime: '6 h',
    contentPost: '''✅ Tips to Prevent Lung Cancer:
1. Quit Smoking:
- Smoking is the number one cause of lung cancer.
- Even secondhand smoke significantly increases the risk.
2. Avoid Exposure to Toxic Fumes or Polluted Areas:
- Stay away from areas with industrial smoke, chemical exposure, or poor air quality (e.g., radon, asbestos).
3. Ensure Good Ventilation at Home:
- Especially in basements or closed spaces to prevent buildup of radon gas, which is a known carcinogen.
4. Eat a Healthy, Balanced Diet:
- Rich in fruits and vegetables, which provide antioxidants that help fight cell damage.
5. Limit processed and fried foods.
6. Exercise Regularly:
- Helps improve lung function and overall immune health.
7. Regular Screenings for High-Risk Individuals:
- Especially for those over 50, former smokers, or people with a family history of cancer.
8. Use Protective Gear in Hazardous Work Environments:
- If you work with chemicals, dust, or fumes, wear masks and follow safety protocols.''',
    likes: 81,
    comments: 53,
    hasImage: true,
    imageUrl:
        'https://c8.alamy.com/comp/BR4XA4/x-ray-showing-lung-cancer-in-an-80-year-old-man-with-a-long-history-BR4XA4.jpg',
    userId: '1',
    postId: '1',
  ),
];
