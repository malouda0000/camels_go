part of "package:special_line_vendors/view/Auth/register/register_screen.dart";

class _DoYouHaveAccount extends StatelessWidget {
  const _DoYouHaveAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) {
          return const LogInScreen();
        }), (route) => false);
      },
      child: Text(
        style: const TextStyle(
          color: AppColors.mainColor,
          fontSize: 12,
        ),
        AppLocalizations.of(context)!.youHaveAccount,
      ),
    );
  }
}

class _OrSignUpWithGoogle extends StatelessWidget {
  const _OrSignUpWithGoogle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 15,
        ),
        const Expanded(
          child: Divider(
            // thickness: 15,
            // height: 30,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Text(
          style: const TextStyle(
            // color: AppColors.mainGreyColor,
            color: AppColors.mainColor,
            fontSize: 12,
          ),
          AppLocalizations.of(context)!.orByUsing,
        ),
        const SizedBox(
          width: 15,
        ),
        const Expanded(
          child: Divider(
            color: Colors.black,
          ),
        ),
        const SizedBox(
          width: 15,
        ),
      ],
    );
  }
}

class _GoogleIcons extends StatelessWidget {
  const _GoogleIcons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const UnderDevScreen()));
          },
          child: const Image(
              image: AssetImage(
            AppImages.facebook,
          )),
        ),
        const SizedBox(
          width: 20,
        ),
        InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const UnderDevScreen()));
          },
          child: const Image(
              image: AssetImage(
            AppImages.google,
          )),
        ),
      ],
    );
  }
}
